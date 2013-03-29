ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require "paperclip/matchers"


Capybara.javascript_driver = :webkit

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run_including focus: true
  config.use_transactional_fixtures = true

  config.include Paperclip::Shoulda::Matchers
  config.include Devise::TestHelpers, :type => :controller
end

def assert_presence(model, field)
  model.should be_invalid
  model.errors[field].join.should match(/can't be blank/)
end

def assert_email(model, field)
  model.should be_invalid
  model.errors[field].join.should match(/is not an email/)
end

def assert_phone_number(model, field)
  model.should be_invalid
  model.errors[field].join.should match(/is not a valid phone number/)
end

def assert_min_words_count(model, field, min_words)
  model.should be_invalid
  model.errors[field].join.should match(/must be greater than #{min_words} words/)
end

def assert_max_words_count(model, field, max_words)
  model.should be_invalid
  model.errors[field].join.should match(/You have exceeded the #{max_words} word count!|must be less than #{max_words} words/)
end

def assert_numericality(model, field)
  model.should be_invalid
  model.errors[field].join.should match(/is not a number/)
end

def assert_numerical_range(model, field, length)
  model.should be_invalid
  model.errors[field].join.should match(/is the wrong length \(should be #{length} characters\)|is too short \(minimum is #{length} characters\)/)
end

def assert_birthdate(model, field)
  model.should be_invalid
  model.errors[field].join.should match(/Must be greater than #{BhsiApplication::BIRTHDATE_LIMIT}|Invalid birthdate format, should be mm\/dd\/yyyy/)
end

# class ActiveRecord::Base
#   mattr_accessor :shared_connection
#   @@shared_connection = nil
#
#   def self.connection
#     @@shared_connection || retrieve_connection
#   end
# end
# ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
