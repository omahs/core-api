# frozen_string_literal: true

module Givings
  module Payment
    class CreateSubscription < ApplicationCommand
      prepend SimpleCommand

      attr_reader :card, :email, :national_id, :offer_id, :payment_method, :user

      def initialize(args)
        @card = args[:card]
        @email = args[:email]
        @national_id = args[:national_id]
        @offer_id = args[:offer_id]
        @payment_method = args[:payment_method]
        @user = args[:user]
      end

      def call
        customer = find_or_create_customer
        payment = create_payment(customer)
        order = Order.from(payment, card)

        Service::Giving::Payment::Orchestrator.new(order:).process
      rescue StandardError => e
        Reporter.log(e, { message: e.message, level: :fatal })
        errors.add(:payment, e.message)
      end

      private

      def find_or_create_customer
        Customer.find_by(user_id: user.id) || Customer.create!(email:, national_id:, name: card.name, user:)
      end

      def create_payment(customer)
        CustomerPayment.create!({ customer:, offer:, paid_date:,
                                  payment_method:, status: :processing })
      end

      def offer
        @offer ||= Offer.find offer_id
      end

      def paid_date
        Time.zone.now
      end
    end
  end
end
