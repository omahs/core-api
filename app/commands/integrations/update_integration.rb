# frozen_string_literal: true

module Integrations
  class UpdateIntegration < ApplicationCommand
    prepend SimpleCommand

    attr_reader :integration_params

    def initialize(integration_params)
      @integration_params = integration_params
    end

    def call
      with_exception_handle do
        integration = Integration.find integration_params[:id]
        integration.update(update_integration_params)
        if integration_params[:webhook_url].present?
          if integration.webhook_url
            update_integration_webhook(integration)
          else
            create_integration_webhook(integration)
          end
        end
        integration
      end
    end

    private

    def update_integration_params
      integration_params.except(:webhook_url)
    end

    def create_integration_webhook(integration)
      IntegrationWebhook.create(url: integration_params[:webhook_url], integration:)
    end

    def update_integration_webhook(integration)
      IntegrationWebhook.where(integration:).last.update(url: integration_params[:webhook_url])
    end
  end
end
