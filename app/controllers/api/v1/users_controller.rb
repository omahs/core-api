module Api
  module V1
    class UsersController < ApplicationController
      def search
        @user = User.find_by(email: params[:email])

        if @user
          render json: UserBlueprint.render(@user, view: :extended)
        else
          render json: { error: 'user not found' }, status: :not_found
        end
      end

      def create
        @user = User.new(user_params)

        if @user.save
          render json: UserBlueprint.render(@user), status: :created
        else
          head :unprocessable_entity
        end
      end

      def can_donate
        @integration = Integration.find_by_id_or_unique_address params[:integration_id]

        if current_user
          render json: { can_donate: current_user.can_donate?(@integration) }
        else
          render json: { can_donate: true }
        end
      end

      def statistics
        user = User.find_by(email: user_params[:email])
        customer = Customer.find_by(email: user_params[:email])

        tickets = Donation.where(user:).count
        non_profits = Donation.where(user:).distinct.count(:non_profit_id)

        causes = total_causes(user)
        if customer
          person = PersonPayment.where(person_id: customer.person_id)
          causes += person.where(receiver_type: 'Cause').map(&:receiver_id)
          non_profits += person.where(receiver_type: 'NonProfit').map(&:receiver_id).uniq.count
          donated = person_payments_amount(person)
        end
        render json: { total_non_profits: non_profits, total_tickets: tickets, total_donated: donated || 0,
                       total_causes: causes.uniq.count }
      end

      private

      def user_params
        params.permit(:email)
      end

      def total_causes(user)
        causes_sql = "SELECT distinct cause_id FROM donations
               left outer join non_profits on non_profits.id = donations.non_profit_id
               left outer join causes on causes.id = non_profits.cause_id
               where donations.user_id = #{user.id}"
        ActiveRecord::Base.connection.execute(causes_sql).to_a.map { |cause| cause['cause_id'] }
      end

      def convert_to_usd(value)
        Currency::Converters.convert_to_usd(value:, from: 'BRL').to_f
      end

      def convert_to_brl(value)
        Currency::Converters.convert_to_brl(value:, from: 'USD').to_f
      end

      def person_payments_amount(payment)
        person_payments_brl = payment.where(currency: 0).sum(:amount_cents) / 100
        person_payments_usd = payment.where(currency: 1).sum(:amount_cents) / 100

        { brl: (person_payments_brl + convert_to_brl(person_payments_usd)),
          usd: (person_payments_usd + convert_to_usd(person_payments_brl)) }
      end
    end
  end
end
