unless Rails.env.production?
  ribon_config = FactoryBot.create(:ribon_config)

<<<<<<< HEAD
  puts "Creating non profits..."
  non_profit = NonProfit.first_or_create!(
    name: "Non Profit",
    status: "active",
    wallet_address: "0x6E060041D62fDd76cF27c582f62983b864878E8F",
    impact_description: "1 day of impact",
  )
=======
  non_profit = FactoryBot.create(:non_profit, :with_impact)
>>>>>>> 101bf7e7d9db754c25c829ddad619eefd81290b5

  integration = FactoryBot.create(:integration)

<<<<<<< HEAD
  puts "Creating integrations..."
  integration = Integration.first_or_create!(
    id: 3,
    name: "Renner",
    status: "active",
    unique_address: 'b3fa97fe-0302-4b00-97ba-df32e3060b74',
    ticket_availability_in_minutes: 30,
  )
  puts "Integrations created."
=======
  user = FactoryBot.create(:user)
>>>>>>> 101bf7e7d9db754c25c829ddad619eefd81290b5

  chain = FactoryBot.create(:chain)

  puts "Seed completed!"
end
