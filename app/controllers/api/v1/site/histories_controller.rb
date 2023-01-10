module Api
  module V1
    module Site
      class HistoriesController < ApplicationController
        def non_profits_total_balance
          if params[:language] == 'pt-BR'
            render json: { non_profits_total_balance: "R$ #{total_brl}" }
          else
            render json: { non_profits_total_balance: "#{total_usd} USDC" }
          end
        end

        def total_donors
          histories_donors = History.all.sum(:total_donors)
          users = Donation.all.pluck(:user_id).uniq.compact.count

          render json: { total_donors: histories_donors + users }
        end

        private

        def convert_to_usd(value)
          Currency::Converters.convert_to_usd(value:, from: 'BRL').round.to_f
        end

        def convert_to_brl(value)
          Currency::Converters.convert_to_brl(value:, from: 'USD').round.to_f
        end

        def donations
          Donation.sum(:value) / 100
        end

        def histories_donations
          History.sum(:total_donations)
        end

        def person_payments_amount
          person_payments_brl = PersonPayment.where(currency: 0).sum(:amount_cents) / 100
          person_payments_usd = PersonPayment.where(currency: 1).sum(:amount_cents) / 100

          { brl: person_payments_brl + convert_to_brl(person_payments_usd),
            usd: person_payments_usd + convert_to_usd(person_payments_brl) }
        end

        def total_brl
          convert_to_brl(donations) + histories_donations + person_payments_amount[:brl]
        end

        def total_usd
          convert_to_usd(histories_donations) + donations + person_payments_amount[:usd]
        end
      end
    end
  end
end
