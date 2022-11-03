# frozen_string_literal: true

module Causes
  class CreateCause < ApplicationCommand
    prepend SimpleCommand
    include Web3

    attr_reader :cause_params

    def initialize(cause_params)
      @cause_params = cause_params
    end

    def call
      with_exception_handle do
        cause = Cause.create!(cause_params)
        cause
      end
    end

  end
end
