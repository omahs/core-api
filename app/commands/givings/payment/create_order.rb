# frozen_string_literal: true

module Givings
  module Payment
    class CreateOrder < ApplicationCommand
      prepend SimpleCommand

      attr_reader :card, :email, :tax_id, :offer, :payment_method, :user, :operation

      def initialize(args)
        @card = args[:card]
        @email = args[:email]
        @tax_id = args[:tax_id]
        @offer = args[:offer]
        @payment_method = args[:payment_method]
        @user = args[:user]
        @operation = args[:operation]
      end

      def call
        customer = find_or_create_customer
        payment = create_payment(customer)
        order = Order.from(payment, card, operation)
        payment_process_result = GivingServices::Payment::Orchestrator.new(payload: order).call
        success_callback(order, payment_process_result)

        payment_process_result
      rescue StandardError => e
        failure_callback(order, payment_process_result)
        Reporter.log(error: e, extra: { message: e.message }, level: :fatal)
        errors.add(:payment, e.message)
      end

      private

      def success_callback(order, _result)
        order.payment.update(status: :paid)
      end

      def failure_callback(order, _result)
        order.payment.update(status: :failed)
      end

      def find_or_create_customer
        Customer.find_by(user_id: user.id) || Customer.create!(email:, tax_id:, name: card.name, user:)
      end

      def create_payment(customer)
        CustomerPayment.create!({ customer:, offer:, paid_date:,
                                  payment_method:, status: :processing })
      end

      def paid_date
        Time.zone.now
      end
    end
  end
end
