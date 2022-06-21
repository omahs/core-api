class MainController < ApplicationController
  def health
    database_ping = NonProfit.first&.id&.present?

    render json: { api: true, database: database_ping }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
