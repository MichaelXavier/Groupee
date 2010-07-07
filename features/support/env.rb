require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= "test"
  require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')

  require 'cucumber/formatter/unicode' # Remove this line if you don't want Cucumber Unicode support
  require 'cucumber/rails/rspec'
  require 'cucumber/rails/world'
  require 'cucumber/rails/active_record'
  require 'cucumber/web/tableish'

  require 'capybara/rails'
  require 'capybara/cucumber'
  require 'capybara/session'
  require 'cucumber/rails/capybara_javascript_emulation' # Lets you click links with onclick javascript handlers without using @culerity or @javascript
  # Capybara defaults to XPath selectors rather than Webrat's default of CSS3. In
  # order to ease the transition to Capybara we set the default here. If you'd
  # prefer to use XPath just remove this line and adjust any selectors in your
  # steps to use the XPath syntax.
  Capybara.default_selector = :css

  Capybara.default_selector = :css

  require 'database_cleaner'
  DatabaseCleaner.orm = 'active_record'
  DatabaseCleaner.strategy = :truncation

end

Spork.each_run do
  ActionController::Base.allow_rescue = false

  DatabaseCleaner.clean

  Dir['lib/test_helpers/**/*.rb'].each {|f| require f}
end
