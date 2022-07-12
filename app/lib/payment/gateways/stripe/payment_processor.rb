module Payment
  module Gateways
    module Stripe
      class PaymentProcessor < Base
        attr_reader :stripe_customer, :stripe_payment_method

        def purchase(order)
          setup_customer(order)
          Billing::UniquePayment.create(stripe_customer:,
                                        stripe_payment_method:, offer: order&.offer)

          {
            external_customer_id: stripe_customer.id,
            external_payment_method_id: stripe_payment_method.id
          }
        end

        def subscribe(order)
          setup_customer(order)
          subscription = Billing::Subscription.create(stripe_customer:, offer: order&.offer)

          {
            external_customer_id: stripe_customer.id,
            external_payment_method_id: stripe_payment_method.id,
            external_subscription_id: subscription.id,
            external_invoice_id: subscription.latest_invoice
          }
        end

        def unsubscribe(subscription)
          Billing::Subscription.cancel(subscription:)
        end

        private

        def setup_customer(order)
          @stripe_payment_method = Entities::PaymentMethod.create(card: order&.card)
          @stripe_customer       = Entities::Customer.create(customer: order&.person&.customer,
                                                             payment_method: @stripe_payment_method)
          Entities::TaxId.add_to_customer(stripe_customer: @stripe_customer,
                                          tax_id: order&.person&.customer&.tax_id)
        end
      end
    end
  end
end
