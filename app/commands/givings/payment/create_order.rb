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
        failure_callback(order, payment_process_result, e.code)
        Reporter.log(error: e, extra: { message: e.message }, level: :fatal)
        errors.add(:message, e.message)
      end

      private

      def success_callback(order, result)
        if result
          order.payment.update(status: :paid)
          order.payment.update(external_id: result[:external_id]) if result[:external_id]
        end

        klass.success_callback(order, result)
      end

      def failure_callback(order, _result, error_code)
        order.payment.update(status: :failed, error_code: error_code)
      end

      def call_add_giving_blockchain_job(order)
        AddGivingToBlockchainJob.perform_later(amount: order.payment.crypto_amount, payment: order.payment)
      end
    end
  end
end
