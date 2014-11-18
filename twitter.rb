require 'twitter'

module Twitter
  class Bot
    attr_reader :query, :limit, :new_tweet
    
    def initialize options={}
      @query = options.fetch(:query) { '#ThoughtOfTheDay' }
      @limit = options.fetch(:limit) { 50 }
      @new_tweet = options.fetch(:new_tweet) { false }
    end

    def start options={}
      results = search(query)
      tweets = take_tweetable(results)
      if tweets.any?
        new_or_retweet tweets.sample
      end
    end

    def new_or_retweet tweet
      puts tweet.text
      if new_tweet
        update tweet
      else
        retweet tweet
      end
    end

    def update tweet
      client.update "RT @#{tweet.user.screen_name}: #{tweet.text}"
    rescue
      retweet tweet
    end

    def retweet tweet
      client.retweet tweet.id
    end

    def search query
      client.search("'#{query}' filter:images -rt", search_options)
    end

    private
    def take_tweetable(tweets)
      tweets.inject([]) do |arr, tweet|
        return arr if arr.size == limit
        arr << tweet if tweetable?(tweet); arr
      end
    end

    def tweetable? tweet
      return if tweet.created_at.to_date < Date.today
      return if tweet.text.length < 100
      return if tweet.hashtags.length > 2
      return if tweet.user_mentions.length > 1
      return if tweet.uris.length > 1
      true
    end

    def search_options
      @search_options ||= { result_type: 'recent' }
    end

    def client
      @client ||= Twitter::REST::Client.new(config)
    rescue Exception => error
      cnt = cnt ? (cnt + 1) : 1
      retry if cnt <= 3
      raise error
    end

    def config
      { consumer_key:        ENV['CONSUMER_KEY'],
        consumer_secret:     ENV['CONSUMER_SECRET'],
        access_token:        ENV['ACCESS_TOKEN'],
        access_token_secret: ENV['ACCESS_SECRET']}
    end
  end
end
