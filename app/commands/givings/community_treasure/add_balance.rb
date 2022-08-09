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
        ribon_contract.add_donation_pool_balance(amount:)
      end

      private

      def default_chain
        Web3::Providers::Networks::MUMBAI
      end

      def ribon_contract
        @ribon_contract ||= Web3::Contracts::RibonContract.new(chain:)
      end
    end
  end
end
