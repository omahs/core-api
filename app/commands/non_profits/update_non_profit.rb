# frozen_string_literal: true

module NonProfits
  class UpdateNonProfit < ApplicationCommand
    prepend SimpleCommand

    attr_reader :non_profit_params

    def initialize(non_profit_params)
      @non_profit_params = non_profit_params
    end

    def call
      with_exception_handle do
        non_profit = NonProfit.find non_profit_params[:id]
        non_profit.update(update_non_profit_params)

        non_profit
      end
    end

    private

    def update_non_profit_params
      non_profit_params
    end
  end
end
