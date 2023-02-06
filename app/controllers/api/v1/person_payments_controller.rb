module Api
  module V1
    class PersonPaymentsController < ApplicationController
      def index
        @person_payments = PersonPayment.order(sortable).page(page).per(per)

        render json: PersonPaymentBlueprint.render(@person_payments, total_items:, page:, total_pages:)
      end

      def find_by_person_community_payments
        person = find_person_by_email_or_wallet(params[:unique_identifier])

        @person_payments = if person
                             person.person_payments.where(receiver_type: 'Cause')
                                   .order(sortable).page(page).per(per)
                           else
                             PersonPayment.none
                           end
        render json: PersonPaymentBlueprint.render(@person_payments, total_items:, page:,
                                                                     total_pages:, view: :cause)
      end

      def find_by_person_direct_payments
        person = find_person_by_email_or_wallet(params[:unique_identifier])

        @person_payments = if person
                             person.person_payments.where(receiver_type: 'NonProfit')
                                   .order(sortable).page(page).per(per)
                           else
                             PersonPayment.none
                           end

        render json: PersonPaymentBlueprint.render(@person_payments, total_items:, page:,
                                                                     total_pages:, view: :non_profit)
      end

      private

      def find_person_by_email_or_wallet(unique_identifier)
        unique_identifier = Base64.strict_decode64(unique_identifier)

        if URI::MailTo::EMAIL_REGEXP.match?(unique_identifier)
          Customer.find_by!(email: unique_identifier).person
        else
          Guest.find_by!(wallet_address: unique_identifier).person
        end
      end

      def sortable
        @sortable ||= params[:sort].present? ? "#{params[:sort]} #{sort_direction}" : 'created_at desc'
      end

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
        @per = params[:per] || 100
      end
    end
  end
end
