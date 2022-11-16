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
      elsif cause_params[:name].present?
        create
      else
        errors.add(:message, I18n.t('causes.create_failed'))
      end
    end

    private

    def create
      pool_address = create_pool
      if pool_address
        cause = Cause.create!(cause_params)
        Pool.create!(address: pool_address, name: cause_params[:name], token:, cause:)
        cause
      end
    rescue StandardError
      errors.add(:message, I18n.t('causes.create_failed'))
    end

    def update
      cause = Cause.find cause_params[:id]
      cause.update(cause_params)
      cause
    rescue StandardError
      errors.add(:message, I18n.t('causes.update_failed'))
    end

    def chain
      Chain.default
    end

    def token
      Token.default
    end

    def create_pool
      transaction_hash = Web3::Contracts::RibonContract.new(chain:).create_pool(token: token.address)
      result = transaction_status(transaction_hash)
      if result == :success
        fetch_pool
      else
        errors.add(:message, I18n.t('pools.create_failed'))
        nil
      end
    rescue StandardError
      errors.add(:message, I18n.t('pools.create_failed'))
    end

    def transaction_status(transaction_hash)
      Web3::Utils::TransactionUtils.new(chain:).transaction_status(transaction_hash)
    end

    def fetch_pool
      result = Graphql::RibonApi::Client.query(Graphql::Queries::FetchPools::Query)
      pool_address = result.data.pools.last.id
      return pool_address unless Pool.where(address: pool_address).first

      errors.add(:message, I18n.t('pools.fetch_failed'))
      nil
    rescue StandardError
      errors.add(:message, I18n.t('pools.fetch_failed'))
    end
  end
end
