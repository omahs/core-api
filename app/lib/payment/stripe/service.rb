module Payment
  module Stripe
    class Service < Payment::Stripe::Base
      attr_reader :payment_method, :customer, :subscription, :card, :offer

      def purchase(transaction)
        @customer = transaction&.customer
        @card = transaction&.card
        @offer = transaction&.payment&.offer

        stripe_payment_method = create_payment_method
        stripe_customer = create_customer(stripe_payment_method)
        add_tax_id(stripe_customer)

        if offer.unique?
          create_unique_payment(stripe_payment_method, stripe_customer)

          {
            "external_customer_id": stripe_customer.id,
            "external_payment_method_id": stripe_payment_method.id
          }
        else
          stripe_subscription = create_subscription(stripe_customer)

          {
            "external_customer_id": stripe_customer.id,
            "external_payment_method_id": stripe_payment_method.id,
            "external_subscription_id": stripe_subscription.id,
            "external_invoice_id": stripe_subscription.latest_invoice
          }
        end
      end

      private

      def create_payment_method
        ::Stripe::PaymentMethod.create({
          type: 'card',
          card: {
            number: card&.number,
            exp_month: card&.expiration_month,
            exp_year: card&.expiration_year,
            cvc: card&.cvv
          }
        })
      end

      def create_customer(payment_method)
        ::Stripe::Customer.create({
          email: customer&.email,
          name: customer&.name,
          payment_method: payment_method.id,
          invoice_settings: {
            default_payment_method: payment_method.id
          }
        })
      end

      def add_tax_id(stripe_customer)
        ::Stripe::Customer.create_tax_id(
          stripe_customer&.id,
          {
            type: 'br_cpf',
            value: customer&.national_id
          }
        )
      end

      def create_subscription(stripe_customer)
        ::Stripe::Subscription.create(
          {
            customer: stripe_customer.id,
            items: [
              { price: offer.external_id }
            ]
          }
        )
      end

      def create_unique_payment(stripe_payment_method, stripe_customer)
        ::Stripe::PaymentIntent.create({
          amount: offer.price_cents,
          currency: offer.currency,
          payment_method: stripe_payment_method,
          customer: stripe_customer,
          confirm: true
        })
      end
    end
  end
end
