# frozen_string_literal: true

module Givings
  module Payment
    module OrderTypes
      class Cryptocurrency
        attr_reader :email, :payment_method, :user, :amount, :transaction_hash

        def initialize(args)
          @email            = args[:email]
          @payment_method   = args[:payment_method]
          @user             = args[:user]
          @amount           = args[:amount]
          @transaction_hash = args[:hash]
        end


        def generate_order
          customer = find_or_create_customer
          payment  = create_payment(customer)
          create_customer_payment_blockchain(payment)
          
          Order.from(payment)
        end

        def process_payment(order)
          {
            customer: order.customer.id,
            payment: order.payment.id,
            hash: transaction_hash
          }
        end

        private

        def find_or_create_customer
          Customer.find_by(user_id: user.id) || Customer.create!(email:, name:, user:)
        end

        def create_payment(customer)
          CustomerPayment.create!({ customer:, paid_date:,
                                    payment_method:, amount_cents:, status: :processing })
        end

        def create_customer_payment_blockchain(payment)
          CustomerPaymentBlockchain.create!(customer_payment: payment, treasure_entry_status: :processing, transaction_hash:)
        end

        def amount_cents
          amount.to_f * 100
        end

        def name
          email.split("@").first
        end

        def paid_date
          Time.zone.now
        end
      end
    end
  end
end
