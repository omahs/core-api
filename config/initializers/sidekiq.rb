sidekiq_config = { url: RibonCoreApi.redis_url }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
  config.error_handlers << proc {|ex,ctx_hash| Reporter.log(error: ex, extra: ctx_hash) }
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end