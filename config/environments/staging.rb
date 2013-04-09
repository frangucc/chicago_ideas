CraigsAdmin::Application.configure do
  config.cache_classes = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = false
  config.assets.compress = true
  config.assets.compile = true
  config.assets.digest = true
  config.assets.precompile += %w( application.js application.css admin.js admin.css invoice.css sponsor_admin.css )
  config.action_mailer.asset_host = "54.225.238.30"
  config.action_mailer.default_url_options = {:host => "54.225.238.30"}


  ActionMailer::Base.smtp_settings = {
    user_name:            "ciwstaging",
    password:             "ciwstaging",
    domain:               "54.225.238.30",
    address:              "smtp.sendgrid.net",
    port:                 587,
    authentication:       :plain,
    enable_starttls_auto: true
  }
  ActionMailer::Base.delivery_method = :smtp
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.filter_parameters = [:password, :card_number, :cvc]
end

CraigsAdmin::Application.config.middleware.use ExceptionNotifier,
  :email_prefix => "[CIW-STAGING] ",
  :sender_address => %{"Error" <err@example.com>},
  :exception_recipients => %w{leandro@meetmantra.com martin@meetmantra.com}
