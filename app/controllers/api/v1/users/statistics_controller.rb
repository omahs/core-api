module Api
  module V1
    module Users
      class StatisticsController < ApplicationController
        def index
          donated = person_payments_amount if customer
          render json: { total_non_profits:, total_tickets: donations.count,
                         total_donated: donated || 0,
                         total_causes: total_causes.uniq.count }
        end

        private

        def user
          @user ||= User.find params[:user_id]
        end

        def customer
          Customer.find_by(email: user.email)
        end

        def person
          PersonPayment.where(person_id: customer.person_id)
        end

        def donations
          @donations = user.donations
        end

        def total_causes
          causes_sql = "SELECT distinct cause_id FROM donations
               left outer join non_profits on non_profits.id = donations.non_profit_id
               left outer join causes on causes.id = non_profits.cause_id
               where donations.user_id = #{user.id}"
          causes = ActiveRecord::Base.connection.execute(causes_sql).to_a.map { |cause| cause['cause_id'] }

          causes += person.where(receiver_type: 'Cause').map(&:receiver_id) if customer
          causes
        end

        def total_non_profits
          total_non_profits = donations.distinct.count(:non_profit_id)
          total_non_profits += person.where(receiver_type: 'NonProfit').map(&:receiver_id).uniq.count if customer
          total_non_profits
        end

        def convert_to_usd(value)
          Currency::Converters.convert_to_usd(value:, from: 'BRL').to_f
        end

        def convert_to_brl(value)
          Currency::Converters.convert_to_brl(value:, from: 'USD').to_f
        end

        def person_payments_amount
          person_payments_brl = person.where(currency: 0).sum(:amount_cents) / 100
          person_payments_usd = person.where(currency: 1).sum(:amount_cents) / 100

          { brl: (person_payments_brl + convert_to_brl(person_payments_usd)),
            usd: (person_payments_usd + convert_to_usd(person_payments_brl)) }
        end
      end
    end
  end
end
