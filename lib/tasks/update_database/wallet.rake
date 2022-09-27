desc 'This task update type column on wallet table'
namespace :wallet do
  task update: :environment do
    Wallet.where(type: "NewIntegrationWallet").update(type: "IntegrationWallet")
  end
end
