Twitter Bot: Search, retweet and update tweet
===========

Based on `twitter` gem

#### How to run?
`rake twitter_bot:run`

#### Task code
```
#!/usr/bin/env rake

require_relative './twitter'

task :default => 'twitter_bot:run'

namespace 'twitter_bot' do
  desc "Search, re-tweet, post tweets"
  task :run do
    bot = Twitter::Bot.new
    bot.start
  end
end
```
#### Defaults
Twitter bot by default searches for #ThoughtOfTheDay hashtag and 
selects first 50 tweets and then takes one random and re-tweets it.

#### Customization
Twitter bot can be customized using following options.
1) Query
2) Limit
3) New tweet

```
bot = Twitter::Bot.new(query: '#rails', limit: 100, new_tweet: true)
bot.start
```
