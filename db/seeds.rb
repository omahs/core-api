unless Rails.env.production?
  ribon_config = FactoryBot.create(:ribon_config) if RibonConfig.count.zero?

  non_profit = FactoryBot.create(:non_profit, :with_impact) if NonProfit.count.zero?

  integration = FactoryBot.create(:integration) if Integration.count.zero?

  user = FactoryBot.create(:user) if User.count.zero?

  chain = FactoryBot.create(:chain) if Chain.count.zero?

  Rails.logger.debug 'Seed completed!' unless Rails.env.test?
end
