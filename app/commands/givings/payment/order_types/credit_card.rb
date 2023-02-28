# frozen_string_literal: true

module Givings
  module Payment
    module OrderTypes
      class CreditCard
        attr_reader :card, :email, :tax_id, :offer, :payment_method,
                    :user, :operation, :integration_id, :cause, :non_profit

        def initialize(args)
          @card           = args[:card]
          @email          = args[:email]
          @tax_id         = args[:tax_id]
          @offer          = args[:offer]
          @payment_method = args[:payment_method]
          @user           = args[:user]
          @operation      = args[:operation]
          @integration_id = args[:integration_id]
          @cause          = args[:cause]
          @non_profit     = args[:non_profit]
        end

        def generate_order
          customer = find_or_create_customer
          payment  = create_payment(customer.person)

          Order.from(payment, card, operation)
        end

        def process_payment(order)
          Service::Givings::Payment::Orchestrator.new(payload: order).call
        end

        def success_callback(order, _result)
          return if non_profit

          call_add_giving_blockchain_job(order)
          send_success_email
        end

        private

        def find_or_create_customer
          Customer.find_by(user_id: user.id) || Customer.create!(email:, tax_id:, name:, user:,
                                                                 person: Person.create!)
        end

        def create_payment(person)
          PersonPayment.create!({ person:, offer:, paid_date:, integration:, payment_method:,
                                  amount_cents:, status: :processing, receiver: })
        end

        def call_add_giving_blockchain_job(order)
          AddGivingToBlockchainJob.perform_later(amount: order.payment.crypto_amount,
                                                 payment: order.payment,
                                                 pool: cause&.default_pool)
        end

        def amount_cents
          offer.price_cents
        end

        def name
          card.name
        end

        def paid_date
          Time.zone.now
        end

        def integration
          Integration.find_by_id_or_unique_address(integration_id)
        end

        def receiver
          non_profit || cause
        end

        def send_success_email
          SendgridWebMailer.send_email(
            receiver: user.email,
            dynamic_template_data: {
              donated_amount: 'price',
              donation_receiver_name: "#{receiver}.name",
              impact: "#{receiver}.impact"
            },
            template_name: "giving_success_#{receiver}_template_id",
            language: user.language
          ).deliver_now
        end
      end
    end
  end
end
