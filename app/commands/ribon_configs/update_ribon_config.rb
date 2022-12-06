# frozen_string_literal: true

module RibonConfigs
  class UpdateRibonConfig < ApplicationCommand
    prepend SimpleCommand

    attr_reader :ribon_config_params

    def initialize(ribon_config_params)
      @ribon_config_params = ribon_config_params
    end


    def call
      ribon_config = RibonConfig.find ribon_config_params[:id]
      byebug
      ribon_config.update(default_ticket_value: ticket_value_cents)
      ribon_config
    end

    private

      def ticket_value_cents
         ribon_config_params[:default_ticket_value].to_f * 100
      end
  end
end
