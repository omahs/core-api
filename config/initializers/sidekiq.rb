sidekiq_config = { url: RibonCoreApi.redis_url }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
  config.error_handlers << proc {|ex,ctx_hash| Reporter.log(error: ex, extra: ctx_hash) }
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_server do |config|
  config.on(:startup) do
    schedule_file = "config/schedule.yml"

    if File.exist?(schedule_file)
      Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
    end
  end
end