# frozen_string_literal: true

module Integrations
  class CreateIntegration < ApplicationCommand
    prepend SimpleCommand
    include Web3

    attr_reader :integration

    def initialize(name:, status:)
      @integration = Integration.new(name:, status:, unique_address:)
    end

    def call
      with_exception_handle do
        IntegrationWallet.create!(encrypted_wallet) if integration.save
      end
    end

    private

    def unique_address
      SecureRandom.uuid
    end

    def encrypted_wallet
      public_key, private_key = Providers::Keys.generate_keypair

      encrypted_key = Utils::Cipher.encrypt(private_key)

      {
        public_key:,
        encrypted_private_key: encode(encrypted_key.cipher_text),
        private_key_iv: encode(encrypted_key.iv),
        integration:
      }
    end

    def encode(text)
      Base64.strict_encode64(text)
    end
  end
end
