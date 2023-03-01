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
          send_success_email
          return if non_profit

          call_add_giving_blockchain_job(order)
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

        def donation_receiver
          return 'non_profit' if non_profit

          'cause'
        end

        def normalized_impact
          if non_profit
            ::Impact::Normalizer.new(
              non_profit,
              non_profit.impact_by_ticket # AJEITAR
            ).normalize.join(' ')
          else
            cause_value = offer.price_cents * 0.2
            donated_value(cause_value)
          end
        end

        def donated_value(value = amount_cents)
          currency = offer.currency == 'brl' ? 'R$ ' : '$ '
          currency + (value / 100.0).to_s
        end

        def send_success_email
          SendgridWebMailer.send_email(
            receiver: user.email,
            dynamic_template_data: {
              direct_giving_value: donated_value,
              receiver_name: receiver&.name,
              direct_giving_impact: normalized_impact
            },
            template_name: "giving_success_#{donation_receiver}_template_id",
            language: user.language
          ).deliver_now
        end
      end
    end
  end
end