module Api
  module V1
    class PersonPaymentsController < ApplicationController
      def index
        @person_payments = PersonPayment.all

        render json: PersonPaymentBlueprint.render(@person_payments)
      end
    end
  end
end
