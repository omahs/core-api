module Payment
  module Gateways
    module Stripe
      module Billing
        class Refund
          def self.create(stripe_payment_intent:)
            ::Stripe::Refund.create({
                                      payment_intent: stripe_payment_intent
                                    })
          end
        end
      end
    end
  end
end
