source 'http://rubygems.org'

gem 'rails', '3.0.0.beta3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql'

gem 'devise',               '1.1.rc0'
gem 'cancan'

group(:development) do
  gem 'quietbacktrace'
end

group(:test) do
  gem "rspec-rails",      ">= 2.0.0.beta"                                                                                                                                           
  gem "autotest"                                                                                                                                                                    
  gem "autotest-rails"                                                                                                                                                              

  #gem 'rspec',              :git => "git://github.com/rspec/rspec.git"
  #gem 'rspec-core',         :git => "git://github.com/rspec/rspec-core.git",         :require => 'rspec/core'
  #gem 'rspec-expectations', :git => "git://github.com/rspec/rspec-expectations.git", :require => 'rspec/expectations'
  #gem 'rspec-mocks',        :git => "git://github.com/rspec/rspec-mocks.git",        :require => 'rspec/mocks'
  #gem 'rspec-rails',        :git => "git://github.com/rspec/rspec-rails.git"

  gem 'capybara'
  gem 'database_cleaner'
  gem 'cucumber-rails'

  gem 'faker'
  #gem 'factory_girl', '~> 1.2.4', :git => 'git://github.com/thoughtbot/factory_girl'
  # Waiting on factory_girl rails 3 compatibility.
  gem 'factory_girl', :git => 'git://github.com/danielb2/factory_girl'
  gem 'rr'
  gem 'quietbacktrace'
end
