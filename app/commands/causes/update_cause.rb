# frozen_string_literal: true

module Causes
  class UpdateCause < ApplicationCommand
    prepend SimpleCommand

    attr_reader :cause_params

    def initialize(cause_params)
      @cause_params = cause_params
    end

    def call
      with_exception_handle do
        cause = Cause.find cause_params[:id]
        cause.update(cause_params)
        cause
      end
    end

  end
end
