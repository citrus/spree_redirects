begin
  require "simplecov"
  SimpleCov.start "rails"
rescue LoadError => e
end

# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require "shoulda"
require "factory_girl"
require "sqlite3"

require "capybara/rails"
require "selenium/webdriver"

Rails.backtrace_cleaner.remove_silencers!

Capybara.default_driver   = :selenium
Capybara.default_selector = :css

# Run any available migration if needed
ActiveRecord::Migrator.migrate File.expand_path("../dummy/db/migrate/", __FILE__)

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| load f }
