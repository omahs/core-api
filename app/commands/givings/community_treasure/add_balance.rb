# frozen_string_literal: true

module Givings
  module CommunityTreasure
    class AddBalance < ApplicationCommand
      prepend SimpleCommand
      attr_reader :amount, :user_identifier, :network

      def initialize(amount:, user_identifier:, network: default_network)
        @amount = amount
        @user_identifier = user_identifier
        @network = network
      end

      def call
        ribon_contract.add_donation_pool_balance(amount:, user: user_identifier)
      end

      private

      def default_network
        Web3::Providers::Networks::MUMBAI
      end

      def ribon_contract
        @ribon_contract ||= Web3::Contracts::RibonContract.new(network:)
      end
    end
  end
end
