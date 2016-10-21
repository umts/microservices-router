# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
CONFIG = YAML.load_file('config/application.yml')
CONFIG.symbolize_keys!