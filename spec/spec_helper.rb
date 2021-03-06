require 'rubygems'
require 'spork'

Spork.prefork do
  # This file is copied to ~/spec when you run 'ruby script/generate rspec'
  # from the project root directory.
  ENV["RAILS_ENV"] ||= 'test'
  require File.dirname(__FILE__) + "/../config/environment" unless defined?(Rails)
  require 'rspec/rails'
  require 'rspec/autorun'

  # Requires supporting files with custom matchers and macros, etc,
  # in ./support/ and its subdirectories.
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

  DatabaseCleaner.strategy = :truncation

  Rspec.configure do |config|
    config.mock_with :rspec
    config.after(:all) do
    end
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  DatabaseCleaner.clean#MXDEBUG: can't decide if this should be in the rspec block or not. its slow as hell
end
