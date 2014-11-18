#!/usr/bin/env rake

require_relative './twitter'

task :default => 'twitter_bot:run'

namespace 'twitter_bot' do
  desc "Search something on twitter and tweet about it"
  task :run do
    bot = Twitter::Bot.new
    bot.start
  end
end
