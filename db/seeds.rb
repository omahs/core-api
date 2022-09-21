unless Rails.env.production?
  ribon_config = FactoryBot.create(:ribon_config) if RibonConfig.count == 0

  non_profit = FactoryBot.create(:non_profit, :with_impact) if NonProfit.count == 0

  integration = FactoryBot.create(:integration) if Integration.count == 0

  user = FactoryBot.create(:user) if User.count == 0

  chain = FactoryBot.create(:chain) if Chain.count == 0

  puts "Seed completed!"
end
