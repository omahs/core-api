class CreateWalletForNonProfits < ActiveRecord::Migration[7.0]
  def change
    NonProfit.all.each do |non_profit|
      non_profit.non_profit_wallets.new(status: :active, public_key: non_profit.read_attribute(:wallet_address))
      non_profit.save
    end
  end
end
