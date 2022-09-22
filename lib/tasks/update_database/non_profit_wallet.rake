desc 'This task creates a wallet for every non profit'
namespace :non_profit_wallet do
  task create: :environment do
    NonProfit.all.each do |non_profit|
      non_profit.non_profit_wallets.create(status: :active, public_key: non_profit.old_wallet_address)
    end
  end
end
