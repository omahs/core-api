# frozen_string_literal: true

module Givings
  module Payment
    class CreateCreditCardRefund < ApplicationCommand
      attr_reader :stripe_payment_intent

      prepend SimpleCommand

      def initialize(args)
        @stripe_payment_intent = args[:stripe_payment_intent]
      end

      def call
        payment = find_person_payment
        refund = Payment::Gateways::Stripe::Billing::Refund.create(stripe_payment_intent: payment.external_id)

        success_refund(refund)
      rescue StandardError => e
        Reporter.log(error: e, extra: { message: e.message }, level: :fatal)
        errors.add(:message, e.message)
      end

      private

      def success_refund(payment)
        payment.update(status: :refunded)
      end

      def find_person_payment
        PersonPayment.find_by({ external_id: @stripe_payment_intent })
      end
    end
  end
end
