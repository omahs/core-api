# frozen_string_literal: true

module Givings
  module Payment
    module OrderTypes
      class Cryptocurrency
        attr_reader :wallet_address, :payment_method, :user, :amount, :transaction_hash, :integration_id

        def initialize(args)
          @wallet_address   = args[:wallet_address]
          @payment_method   = args[:payment_method]
          @user             = args[:user]
          @amount           = args[:amount]
          @transaction_hash = args[:transaction_hash]
          @integration_id   = args[:integration_id]
        end

        def generate_order
          guest    = find_or_create_guest
          payment  = create_payment(guest.person)
          create_blockchain_transaction(payment)

          Order.from(payment)
        end

        def process_payment(order)
          {
            person: order.payment.person.id,
            payment: order.payment.id,
            hash: transaction_hash
          }
        end

        private

        def find_or_create_guest
          Guest.find_by(wallet_address:) || Guest.create!(wallet_address:, person: Person.create!)
        end

        def create_payment(person)
          PersonPayment.create!({ person:, paid_date:, integration:,
                                  payment_method:, amount_cents:, status: :processing })
        end

        def create_blockchain_transaction(payment)
          PersonBlockchainTransaction.create!(person_payment: payment, treasure_entry_status: :processing,
                                              transaction_hash:)
        end

        def amount_cents
          amount.to_f * 100
        end

        def paid_date
          Time.zone.now
        end

        def integration
          Integration.find_by_id_or_unique_address(integration_id)
        end
      end
    end
  end
end
