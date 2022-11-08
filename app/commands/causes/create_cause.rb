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
        # transaction_hash = create_pool
        transaction_hash="0x1f8e594f1c3ee99b8e68e77c3f2da7e6cad04dfd74e7d17c6eb75571f0543ed8"
        result = transaction_utils.transaction_status(transaction_hash)
        if (result == :success)
          Cause.create!(cause_params)
        else
          errors.add(:message, I18n.t('pool.create_failed'))
        end
      end
    end

    private

    def chain
      Chain.default
    end

    def token
      Token.default
    end

    def transaction_utils
      @transaction_utils ||= Web3::Utils::TransactionUtils.new(chain:)
    end

    def create_pool
      Web3::Contracts::RibonContract.new(chain:).create_pool(token: token.address)
    end
  end
end
