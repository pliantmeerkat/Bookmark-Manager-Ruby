require 'capybara/rspec'
require 'simplecov'
require 'simplecov-console'
require_relative './setup_test_database'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
                                                                 SimpleCov::Formatter::Console,
                                                                 # Want a nice code coverage website? Uncomment this next line!
                                                                 # SimpleCov::Formatter::HTMLFormatter
                                                               ])
SimpleCov.start

ENV['ENVIRONMENT'] = 'test'

RSpec.configure do |config|
  config.before(:each) { setup_test_database }
end
require File.join(File.dirname(__FILE__), '..', 'app.rb')

Capybara.app = App

RSpec.configure do |config|
  config.after(:suite) do
    puts "\n\e[35m------------------------------\e[0m"
    puts "\e[34mProcessing Robotests!\e[0m"
    puts "\e[31mDo not anger the Robocop\e[0m"
    puts "\e[36mJack is cool\e[10m"
  end
end
