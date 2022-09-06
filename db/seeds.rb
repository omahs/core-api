unless Rails.env.production?
  puts "Creating Ribon Config..."
  ribon_config = FactoryBot.create(:ribon_config)
  puts "Ribon Config created."

  puts "Creating non profits..."
  non_profit = FactoryBot.create(:non_profit, :with_impact)
  puts "Non profits created."

  puts "Creating integrations..."
  integration = FactoryBot.create(:integration)
  puts "Integrations created."

  puts "Creating admin..."
  admin = FactoryBot.create(:admin)
  puts "Admin created."

  puts "Creating test user..."
  user = FactoryBot.create(:user)
  puts "Test user created."

  puts "Creating mumbai chain..."
  chain = FactoryBot.create(:chain)
  puts "Mumbai chain created."
end
