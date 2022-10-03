module Vouchers
  class WebhookJob < ApplicationJob
    queue_as :default

    def perform(voucher)
      response = Request::ApiRequest.post(voucher.integration.webhook_url,
                                          body: VoucherBlueprint.render(voucher))

      raise StandardError, 'webhook failed' if response.status != 200
    end
  end
end
