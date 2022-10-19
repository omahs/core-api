module Api
  module V1
    class PersonPaymentsController < ApplicationController
      def index
        sortable = params[:sort].present? ? "#{params[:sort]} #{sort_direction}" : 'created_at desc'

        @person_payments = PersonPayment.order(sortable).page(@page).per(@per)

        render json: PersonPaymentBlueprint.render(@person_payments, total_items:, page:, total_pages:)
      end

      private

      def sort_direction
        %w[asc desc].include?(params[:sort_dir]) ? params[:sort_dir] : 'asc'
      end

      def total_pages
        @person_payments.page(@page).total_pages
      end

      def total_items
        @total_items = @person_payments.count
      end

      def page
        @page = params[:page] || 1
      end

      def per
        @per = params[:per] || 10
      end
    end
  end
end
