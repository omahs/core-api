class MainController < ApplicationController
  def health
    database_ping = NonProfit.first&.id&.present?
    redis_ping = RibonCoreApi.redis.ping

    render json: { api: true, redis_ping:, database: database_ping }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
