# frozen_string_literal: true

module Givings
  module CommunityTreasure
    class AddBalance < ApplicationCommand
      prepend SimpleCommand
      attr_reader :amount, :chain

      def initialize(amount:, chain: default_chain)
        @amount = amount
        @chain = chain
      end

      def call
        ribon_contract.add_pool_balance(donation_pool_address:, amount:)
      end

      private

      def default_chain
        @default_chain ||= Chain.default
      end

      def donation_pool_address
        '0x174C30d9D70d0f18b18736e4a1ddbba9EF9D0330'
      end

      def ribon_contract
        @ribon_contract ||= Web3::Contracts::RibonContract.new(chain:)
      end
    end
  end
end
