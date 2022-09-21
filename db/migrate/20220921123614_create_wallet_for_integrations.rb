class CreateWalletForIntegrations < ActiveRecord::Migration[7.0]
  def change
    IntegrationWallet.all.each do |integration_wallet|
      integration = integration_wallet.integration
      integration.build_new_integration_wallet(
        public_key: integration_wallet.public_key, 
        encrypted_private_key: integration_wallet.private_key, 
        private_key_iv: integration_wallet.private_key_iv
      )
      integration.save
    end
  end
end
