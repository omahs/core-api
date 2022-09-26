# frozen_string_literal: true

module Integrations
  class CreateIntegration < ApplicationCommand
    prepend SimpleCommand
    include Web3

    attr_reader :integration_params

    def initialize(integration_params)
      @integration_params = integration_params
    end

    def call
      with_exception_handle do
        integration = Integration.create!(enriched_integration_params)
        wallet      = integration.create_new_integration_wallet!(encrypted_wallet)
        wallet.add_balance(ribon_contract, amount)

        integration
      end
    end

    private

    def enriched_integration_params
      integration_params.merge(unique_address:)
    end

    def unique_address
      SecureRandom.uuid
    end

    def encrypted_wallet
      public_key, private_key = Providers::Keys.generate_keypair

      encrypted_key = Utils::Cipher.encrypt(private_key)

      {
        public_key:,
        encrypted_private_key: encode(encrypted_key.cipher_text),
        private_key_iv: encode(encrypted_key.iv)
      }
    end

    def ribon_contract
      @ribon_contract ||= Web3::Contracts::RibonContract.new(chain:)
    end

    def amount
      @amount ||= RibonConfig.minimum_integration_amount
    end

    def chain
      @chain ||= Chain.default
    end

    def encode(text)
      Base64.strict_encode64(text)
    end
  end
end
