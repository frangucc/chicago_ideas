# Load the rails application
require File.expand_path('../application', __FILE__)

# this is very useful, specifically for the time_ago_in_words method
include ActionView::Helpers::DateHelper

# showing the output of log entries requires Pretty Print
require 'pp'

# Initialize the rails application
CraigsAdmin::Application.initialize!

DocRaptor.api_key 'tl8fHT64wxhkLUTW0Y6V'


@auth_net = YAML.load_file(Rails.root + 'config/authorize_net.yml')

AUTHNET_LOGIN = @auth_net["login"]
AUTHNET_KEY   = @auth_net["key"]
AUTHNET_ENV   = @auth_net["env"].to_sym
BING_MAPS_API_KEY = "AuGgGandaCq-kaRoSzngT0VCwi8MWNk0BgOj5pxdiJvooLyZrGwoNnFpT3ZRBMTi"
