# Load the rails application
require File.expand_path('../application', __FILE__)

# this is very useful, specifically for the time_ago_in_words method
include ActionView::Helpers::DateHelper

# showing the output of log entries requires Pretty Print
require 'pp'

# Initialize the rails application
CraigsAdmin::Application.initialize!

DocRaptor.api_key 'tl8fHT64wxhkLUTW0Y6V'


AUTHNET_LOGIN = "2y9kBc3rXn"
AUTHNET_KEY = "8SXA34Ag6qa28SuH"
AUTHNET_ENV = :sandbox
BING_MAPS_API_KEY = "AuGgGandaCq-kaRoSzngT0VCwi8MWNk0BgOj5pxdiJvooLyZrGwoNnFpT3ZRBMTi"
