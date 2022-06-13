module Payment
  module Stripe
    class CancelService < Payment::Stripe::Base
      def cancel(subscription)
        ::Stripe::Subscription.delete(subscription.external_identifier)
      end
    end
  end
end
