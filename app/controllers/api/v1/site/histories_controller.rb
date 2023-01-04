module Api
  module V1
    module Site
      class HistoriesController < ApplicationController
        def index
          @histories = History.all

          render json: HistoryBlueprint.render(@histories)
        end

        def total_donations
          histories = History.all

          histories_donations = histories.sum(:total_donations).round.to_f
          donations = Donation.all.sum(:value).round.to_f / 100

          total_usd = convert_to_usd(histories_donations) + donations
          total_brl = convert_to_brl(donations) + histories_donations

          render json: HistoryBlueprint.render(histories, view: :donations, language: params[:language],
                                                          total_usd:, total_brl:)
        end

        def total_donors
          @histories = History.all

          render json: HistoryBlueprint.render(@histories, view: :donors)
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
