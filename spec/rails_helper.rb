ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
end

#
# capybara
#
require 'capybara/rspec'

#
# database-cleaner
#
require 'database_cleaner'

RSpec.configure do |config|
  config.before(:suite)          { DatabaseCleaner.clean_with(:truncation) }
  config.before(:each)           { DatabaseCleaner.strategy = :transaction }
  config.before(:each, js: true) { DatabaseCleaner.strategy = :truncation }
  config.before(:each)           { DatabaseCleaner.start }
  config.append_after(:each)     { DatabaseCleaner.clean }
end

#
# shoulda-matchers
#
require 'shoulda-matchers'
