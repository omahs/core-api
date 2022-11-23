# frozen_string_literal: true

module Configs
  class UpdateRibonConfig < ApplicationCommand
    prepend SimpleCommand

    attr_reader :ribon_config_params

    def initialize(ribon_config_params)
      @ribon_config_params = ribon_config_params
    end

    def call

      ribon_config = RibonConfig.find ribon_config_params[:id]
  
      ribon_config.update(ribon_config_params)
      ribon_config
    end
  end
end
