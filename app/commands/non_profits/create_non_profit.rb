# frozen_string_literal: true

module NonProfits
  class CreateNonProfit < ApplicationCommand
    prepend SimpleCommand
    include Web3

    attr_reader :non_profit_params

    def initialize(non_profit_params)
      @non_profit_params = non_profit_params
    end

    def call
      with_exception_handle do
        non_profit = NonProfit.create!(non_profit_params)

        non_profit
      end
    end
  end
end
