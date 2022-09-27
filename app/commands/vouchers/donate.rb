# frozen_string_literal: true

module Vouchers
  class Donate < ApplicationCommand
    prepend SimpleCommand
    attr_reader :donation_command, :integration, :donation, :external_id

    def initialize(donation_command:, integration:, external_id:)
      @donation_command =  donation_command
      @integration = integration
      @external_id = external_id
      @voucher = Voucher.new(integration:, external_id:)
    end

    def call
      with_exception_handle do
        if voucher.valid?
          @donation = donation_command.call
          create_voucher
        else
          errors.add(:message, I18n.t('donations.blocked_message'))
        end
      end
    end

    def create_voucher
      Voucher.create(external_id: external_id, integration: integration, donation: donation)
    end
  end
end
