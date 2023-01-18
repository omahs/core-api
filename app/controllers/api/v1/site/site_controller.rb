module Api
  module V1
    module Site
      class SiteController < ApplicationController
        def non_profits
          @non_profits = NonProfit.where(status: :active).last(3)
          render json: SiteNonProfitsBlueprint.render(@non_profits, language: params[:language])
        end

        def total_donations
          balance = BalanceHistory
                    .where('created_at > ?', Time.zone.yesterday)
                    .where('created_at < ?', Time.zone.today).sum(:balance)&.round
          if params[:language] == 'pt-BR'
            total_brl = convert_to_brl(balance)
            render json: { total_donations: "R$ #{total_brl&.round}" }
          else
            render json: { total_donations: "#{balance&.round} USDC" }
          end
        end

        def total_impacted_lives
          render json: { total_impacted_lives: '470.770' }
        end

        private

        def convert_to_brl(value)
          Currency::Converters.convert_to_brl(value:, from: 'USD').round.to_f
        end
      end
    end
  end
end
