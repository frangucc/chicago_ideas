# Load the rails application
require File.expand_path('../application', __FILE__)

# this is very useful, specifically for the time_ago_in_words method
include ActionView::Helpers::DateHelper

# showing the output of log entries requires Pretty Print
require 'pp'

# Initialize the rails application
CraigsAdmin::Application.initialize!

DocRaptor.api_key 'D0m6bORzGV62RKxT5Hfb'


if File.exists?(Rails.root + 'config/authorize_net.yml')
  @auth_net = YAML.load_file(Rails.root + 'config/authorize_net.yml')
else
  @auth_net = { "login" => "2y9kBc3rXn", "key" => "8SXA34Ag6qa28SuH", "env" => :sandbox }
end

AUTHNET_LOGIN = @auth_net["login"]
AUTHNET_KEY   = @auth_net["key"]
AUTHNET_ENV   = @auth_net["env"].to_sym

BING_MAPS_API_KEY = "AuGgGandaCq-kaRoSzngT0VCwi8MWNk0BgOj5pxdiJvooLyZrGwoNnFpT3ZRBMTi"
GOOGLE_ANALYTICS_ACCOUNT_ID = "UA-27972061-1"
BASE_DOMAIN_NAME = "chicagoideas.com"
