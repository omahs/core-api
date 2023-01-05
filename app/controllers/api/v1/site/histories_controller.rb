module Api
  module V1
    module Site
      class HistoriesController < ApplicationController
        def non_profits_total_balance
          histories_donations = History.all.sum(:total_donations)

          donations = Donation.all.sum(:value) / 100
          total_usd = convert_to_usd(histories_donations) + donations
          total_brl = convert_to_brl(donations) + histories_donations

          if params[:language] == 'pt-BR'
            render json: { non_profits_total_balance: total_brl }
          else
            render json: { non_profits_total_balance: total_usd }
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
      end
    end
  end
end
