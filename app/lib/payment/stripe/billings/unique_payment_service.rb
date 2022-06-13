module Payment
  module Stripe
    module Billings
      class UniquePaymentService < Payment::Stripe::Base
        def call(payment_method:, customer:, amount:, currency:)
          ::Stripe::PaymentIntent
            .create({ amount: amount_cents(amount), currency: currency,
                       payment_method: payment_method, customer: customer, confirm: true })
        end

        private

        def amount_cents(amount)
          amount * 100
        end
      end
    end
  end
end