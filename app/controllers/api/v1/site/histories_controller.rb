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

          donations = Donation.all.sum(:value).round.to_f
          
          payments = PersonPayment.where(receiver_type: "NonProfit").sum(:amount_cents) / 100

          total = (donations + payments)


        
          render json: HistoryBlueprint.render(histories, view: :donations, language: params[:language])
        end

        def total_donors
          @histories = History.all

          render json: HistoryBlueprint.render(@histories, view: :donors)
        end

        private

        def all_donations(total)
          Currency::Converters.convert_to_usd(value: total, from: 'BRL').round.to_f
        end
      end
    end
  end
end
