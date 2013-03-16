source 'http://rubygems.org'

gem 'rails', '3.1.11'
gem 'aws-sdk', '~> 1.3.4'
gem 'nested_form'
# our database of choice for key constrained, transaction enforced critical business data
gem 'mysql2'
gem 'foreigner'
# mongodb is perfect for logging and analytics which we care less about
# gem "mongoid", '2.4.2'
gem "bson_ext"

# Bundle the extra gems:
gem 'devise', '1.5.3'
gem 'devise_invitable'
gem 'httparty'
gem 'GeoRuby'
gem 'spatial_adapter'
gem 'formtastic', '2.1.0'
gem 'haml'
# pagination
gem 'kaminari'
# file uploads
gem 'paperclip'
gem 'fog'
# markdown
gem 'redcarpet'
gem 'carmen'
gem 'zip-code-info'

# pdf-generation
gem 'doc_raptor'
gem 'pdfkit'
gem 'wkhtmltopdf-binary'

# for managing cron job
gem 'whenever'

# search via sphinx deamon
gem 'thinking-sphinx', '2.0.10'

# social
gem 'koala'
gem 'twitter'
gem 'omniauth-twitter'
gem 'omniauth-facebook'

# jquery
gem 'jquery-rails', '1.0.14'

# css framework
gem 'bourbon', :git => 'git@github.com:thoughtbot/bourbon.git', :ref => 'e88945ad8a3f7f40c04319ee4b7214e7bed0e2f7'

# my gems
gem 'hot_body', '0.1.1'
gem 'json_output_helper', '0.1.0'
gem 'dynamic_models'
gem 'capistrano'
gem 'rvm-capistrano'
gem 'unicorn'

# Authorize.net
gem 'authorize-net'

# js environment
gem 'execjs'
gem 'therubyracer'

# for exceptions duh
gem 'exception_notification'

# async stuff like mailing
gem 'daemons'
gem 'delayed_job_active_record', "0.4.2"

# third party SAS solution for monitoring performance
group :production do
  gem 'newrelic_rpm'
end

# useful in development
group :development do
  gem 'guard'
  gem 'guard-rspec'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test do
  gem 'simplecov', :require => false
  gem "shoulda-matchers"
  gem 'rb-fsevent'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'capybara-webkit'
end

# test-only gems (accessable to development so their generators and rake tasks are available)
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'debugger'
end
