ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require 'factory_girl_rails'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'rspec_api_documentation/dsl'

ActiveRecord::Migration.maintain_test_schema!
RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = true
end
