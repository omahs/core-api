# frozen_string_literal: true

module Givings
  module Payment
    module OrderTypes
      class CreditCard
        attr_reader :card, :email, :tax_id, :offer, :payment_method, :user, :operation, :integration_id

        def initialize(args)
          @card           = args[:card]
          @email          = args[:email]
          @tax_id         = args[:tax_id]
          @offer          = args[:offer]
          @payment_method = args[:payment_method]
          @user           = args[:user]
          @operation      = args[:operation]
          @integration_id = args[:integration_id]
        end

        def generate_order
          customer = find_or_create_customer
          payment  = create_payment(customer.person)

          Order.from(payment, card, operation)
        end

        def process_payment(order)
          Service::Givings::Payment::Orchestrator.new(payload: order).call
        end

        private

        def find_or_create_customer
          Customer.find_by(user_id: user.id) || Customer.create!(email:, tax_id:, name:, user:,
                                                                 person: Person.create!)
        end

        def create_payment(person)
          PersonPayment.create!({ person:, offer:, paid_date:, integration_id:,
                                  payment_method:, amount_cents:, status: :processing })
        end

        def refund; end

        def amount_cents
          offer.price_cents
        end

        def name
          card.name
        end

        def paid_date
          Time.zone.now
        end
      end
    end
  end
end
