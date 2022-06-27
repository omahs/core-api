if Rails.env.production?
  Sentry.init do |config|
    config.dsn = RibonCoreApi.config[:sentry][:dsn_url]
    config.breadcrumbs_logger = [:active_support_logger, :http_logger]
  end
end
