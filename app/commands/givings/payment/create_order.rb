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
        print(e)
        failure_callback(order, payment_process_result)
        Reporter.log(error: e, extra: { message: e.message }, level: :fatal)
        errors.add(:message, e.message)
      end

      private

      def success_callback(order, _result)
        print(_result)
        if(_result && _result[:external_id])
          order.payment.update(status: :paid, external_id: _result[:external_id])
        end
        call_add_giving_blockchain_job(order) if klass.payment_method.eql?(:credit_card)
      end

      def failure_callback(order, _result)
        order.payment.update(status: :failed)
      end

      def call_add_giving_blockchain_job(order)
        AddGivingToBlockchainJob.perform_later(amount: order.payment.crypto_amount, payment: order.payment)
      end
    end
  end
end
