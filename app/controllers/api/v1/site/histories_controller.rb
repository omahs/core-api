module Api
  module V1
      module Site
        class HistoriesController < ApplicationController
          def index
          @histories = History.all

          render json: HistoryBlueprint.render(@histories)
          end

          def total_donations
            @histories = History.all

            render json: HistoryBlueprint.render(@histories, view: :donations)
          end

           def total_donors
            @histories = History.all

            render json: HistoryBlueprint.render(@histories, view: :donors)
          end
        end
      end
    end
end
