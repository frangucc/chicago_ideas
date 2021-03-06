# this file constantizes, documents and freezes environment veriables which are used by the application
# yes, this file could be dried up, but I think it's useful to see and read the different options
# -----------------------------------------------------------------------------------------------------

# The name of this business, to be used throughout the application
BUSINESS_NAME = ENV['BUSINESS_NAME'].freeze

# the from address used when sending email to customers, and also the email address used when delivering email to the admin (e.g. from the conact form)
BUSINESS_EMAIL = ENV['BUSINESS_EMAIL'].freeze

# emails sent in development are intercepted and delivered to the developer, so we dont bombard customers by accident
DEVELOPER_EMAIL = ENV['DEVELOPER_EMAIL'].freeze

# bing maps api key for static maps
# BING_MAPS_API_KEY = ENV['BING_MAPS_API_KEY'].freeze

# we use AWS as a backend for fog and paperclip
AWS_ACCESS_KEY_ID = ENV['AWS_ACCESS_KEY_ID'].freeze
AWS_SECRET_ACCESS_KEY = ENV['AWS_SECRET_ACCESS_KEY'].freeze
S3_NAMESPACE = ENV['S3_NAMESPACE'].freeze
S3_CLOUDFRONT_DOMAIN = ENV['S3_CLOUDFRONT_DOMAIN'].freeze

# for onmiauth with facebook and facebook connect/widgets etc
FACEBOOK_CLIENT_ID = ENV['FACEBOOK_CLIENT_ID'].freeze
FACEBOOK_SECRET = ENV['FACEBOOK_SECRET'].freeze
# for displaying to your customers
FACEBOOK_FAN_PAGE_NAME = ENV['FACEBOOK_FAN_PAGE_NAME'].freeze
FACEBOOK_FAN_PAGE_ID = ENV['FACEBOOK_FAN_PAGE_ID'].freeze

# for omniauth with twitter
TWITTER_CONSUMER_KEY = ENV['TWITTER_CONSUMER_KEY'].freeze
TWITTER_CONSUMER_SECRET = ENV['TWITTER_CONSUMER_SECRET'].freeze
# for displaying to your customers
TWITTER_SCREEN_NAME = ENV['TWITTER_SCREEN_NAME'].freeze

DOC_RAPTOR_KEY = ENV['DOC_RAPTOR_KEY'].freeze
DOC_RAPTOR_TEST = ENV['DOC_RAPTOR_TEST'].freeze

