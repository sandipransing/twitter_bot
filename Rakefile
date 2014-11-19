#!/usr/bin/env rake

require_relative './twitter'

task :default => 'twitter_bot:run'

namespace 'twitter_bot' do
  desc "Search something on twitter and tweet about it"
  task :run do
    options = {}
    options.merge!(query: ENV['query']) if ENV['query']
    options.merge!(limit: ENV['limit'].to_i) if ENV['limit']
    options.merge!(new_tweet: ENV['new_tweet']) if ENV['new_tweet']
    
    Twitter::Bot.new(options).start
  end
end
