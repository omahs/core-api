# frozen_string_literal: true

module Givings
  module Payment
    class CreateOrder < ApplicationCommand
      prepend SimpleCommand

      attr_reader :klass

      def initialize(klass, args)
        @klass = klass.new(args)
      end

      def call
        order = klass.generate_order
        payment_process_result = klass.process_payment(order)

        success_callback(order, payment_process_result)

        payment_process_result
      rescue StandardError => e
        failure_callback(order, payment_process_result)
        Reporter.log(error: e, extra: { message: e.message }, level: :fatal)
        errors.add(:message, e.message)
      end

      private

      def success_callback(order, _result)
        transaction_hash = call_add_balance_command
        order.payment.update(status: :paid)
        order.payment.create_customer_payment_blockchain(treasure_entry_status: :processing,
                                                         transaction_hash:)
      end

      def failure_callback(order, _result)
        order.payment.update(status: :failed)
      end

      def call_add_balance_command
        Givings::CommunityTreasure::AddBalance
          .call(amount: order.payment.amount, user_identifier: order.customer.email).result
      end
    end
  end
end
