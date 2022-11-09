# frozen_string_literal: true

module Causes
  class UpsertCause < ApplicationCommand
    prepend SimpleCommand
    include Web3

    attr_reader :cause_params

    def initialize(cause_params)
      @cause_params = cause_params
    end

    def call
      if cause_params[:id].present?
        update
      else
        create
      end
    end

    private

    def create
      Rails.logger.debug('aquiiiii')
      transaction_hash = create_pool
      Rails.logger.debug(transaction_hash)
      result = transaction_status(transaction_hash)
      Rails.logger.debug(result)
      if result == :success
        pool_address = fetch_pool
        Rails.logger.debug(pool_address)
        if pool_address
          cause = Cause.create!(cause_params)
          Pool.create!(address: pool_address, name: cause_params[:name], token:, cause:)
          cause
        else
          errors.add(:message, I18n.t('pools.fetch_failed'))
        end
      else
        errors.add(:message, I18n.t('pools.create_failed'))
      end
    rescue StandardError
      errors.add(:message, I18n.t('causes.create_failed'))
    end

    def update
      with_exception_handle do
        cause = Cause.find cause_params[:id]
        cause.update(cause_params)
        cause
      end
    end

    def chain
      Chain.default
    end

    def token
      Token.default
    end

    def transaction_status(transaction_hash)
      Web3::Utils::TransactionUtils.new(chain:).transaction_status(transaction_hash)
    end

    def create_pool
      Web3::Contracts::RibonContract.new(chain:).create_pool(token: token.address)
    end

    def fetch_pool
      result = Graphql::RibonApi::Client.query(Graphql::Queries::FetchPools::Query)
      pool_address = result.data.pools.last.id
      return pool_address unless Pool.where(address: pool_address).first
    end
  end
end
