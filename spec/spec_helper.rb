require 'codeclimate-test-reporter'
require 'factory_girl_rails'
require 'simplecov'
require 'database_cleaner'

CodeClimate::TestReporter.start if ENV['CI']
SimpleCov.start 'rails'
SimpleCov.start do
  add_filter '/config/'
  add_filter '/spec/'
end

RSpec.configure do |config|
  config.before :all do
    DatabaseCleaner.clean_with :truncation
    DatabaseCleaner.clean
    FactoryGirl.reload
  end
  config.include FactoryGirl::Syntax::Methods
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  def status_code(code_symbol)
    Rack::Utils::SYMBOL_TO_STATUS_CODE.fetch code_symbol
  end
end
