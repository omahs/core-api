module Webhooks
  class StripeController < ApplicationController
    def events
      payload = request.body.read
      sig_header = request.env['HTTP_STRIPE_SIGNATURE']
      event = nil

      begin
        event = Stripe::Webhook.construct_event(
          payload, sig_header, endpoint_secret
        )
      rescue JSON::ParserError => e
        # Invalid payload
        head :unprocessable_entity
      rescue Stripe::SignatureVerificationError => e
        # Invalid signature
        head :forbidden
      end

      return unless event

      result = event.data.object
      external_id = result['payment_intent']

      # Handle the event
      case event.type
      when 'charge.refunded'
        update_status(external_id, 'refunded') if external_id
      when 'charge.refund.updated'
        update_status(external_id, 'refund_failed') if external_id
      else
        Rails.logger.debug { "Unhandled event type: #{event.type}" }
      end
      nil
    end

    private

    def endpoint_secret
      RibonCoreApi.config[:stripe][:endpoint_secret]
    end

    def update_status(external_id, status)
      PersonPayment.where(external_id:).last&.update(status:)
    end
  end
end
