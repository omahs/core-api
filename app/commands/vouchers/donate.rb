# frozen_string_literal: true

module Vouchers
  class Donate < ApplicationCommand
    prepend SimpleCommand
    attr_reader :donation_command, :integration, :external_id, :voucher

    def initialize(donation_command:, integration:, external_id:)
      @donation_command = donation_command
      @integration = integration
      @external_id = external_id
      @voucher = Voucher.new(integration:, external_id:)
    end

    def call
      with_exception_handle do
        if voucher.valid?
          command = call_donation_command
          create_voucher(command.result) if command.success?
        else
          errors.add(:message, I18n.t('donations.blocked_message'))
        end
      end
    end

    private

    def call_donation_command
      donation_command.call
    end

    def create_voucher(donation)
      Voucher.create(external_id:, integration:, donation:)
    end
  end
end
