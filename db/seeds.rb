unless Rails.env.production?
  puts "Creating Ribon Config..."
  RibonConfig.create!(default_ticket_value: 100, minimum_integration_amount: 10,
                      default_chain_id: Web3::Providers::Networks::POLYGON[:chain_id])
  puts "Ribon Config created."

  puts "Creating mumbai chain..."
  Chain.create!(Web3::Providers::Networks::MUMBAI)
  puts "Mumbai chain created."

  puts 'Creating polygon chain...'
  Chain.create!(Web3::Providers::Networks::POLYGON)
  puts "Polygon chain created."
end