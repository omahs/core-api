module Integrations
  class IntegrationsController < ActionController::API
    include ApiKeyAuthenticatable

    prepend_before_action :authenticate_with_api_key!

    def index
      render json: { message: 'Authorized!' }, status: :ok
    end
  end
end
