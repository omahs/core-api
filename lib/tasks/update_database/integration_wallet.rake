desc 'This task creates a wallet for every integration'
namespace :new_integration_wallet do
  task create: :environment do
    IntegrationWallet.all.each do |integration_wallet|
      integration = integration_wallet.integration
      integration.create_new_integration_wallet(
        public_key: integration_wallet.public_key, 
        encrypted_private_key: integration_wallet.encrypted_private_key, 
        private_key_iv: integration_wallet.private_key_iv
      )
    end
  end
end