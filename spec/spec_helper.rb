require 'simplecov'
SimpleCov.start 'rails'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

RSpec.configure do |config|
  config.mock_with :rspec
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.global_fixtures = :all
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end

def assert_presence(model, field)
  model.should be_invalid
  model.errors[field].join.should match(/can't be blank/)
end

def assert_email(model, field)
  model.should be_invalid
  model.errors[field].join.should match(/is not an email/)
end

def assert_max_words_count(model, field, max_words)
  model.should be_invalid
  model.errors[field].join.should match(/You have exceeded the #{max_words} word count!/)
end
