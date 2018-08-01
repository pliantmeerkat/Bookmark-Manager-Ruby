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
    puts '------------------------------'
    puts "\e[33mProcessing Robotests!\e[0m"
    puts "\e[33mDo not anger the Robocop\e[0m"
    puts "\e[33mJack is cool\e[0m"
  end
end
