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
      transaction_hash = create_pool
      result = transaction_utils.transaction_status(transaction_hash)
      if (result == :success)
        pools = fetch_pools(0,10)
        byebug
        if(pools && pools[pools.last-2])
          cause = Cause.create!(cause_params)
          Pool.create!(address: pools[pools.last-2], name: cause_params[:name], token: token, cause: cause)
        else
          errors.add(:message, I18n.t('pools.fetch_failed'))
        end
      else
        errors.add(:message, I18n.t('pools.create_failed'))
      end
    rescue StandardError
      errors.add(:message, I18n.t('causes.create_failed'))
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

    def fetch_pools(index,length)
      Web3::Contracts::RibonContract.new(chain:).fetch_pools(index:,length:)
    end
  end
end
