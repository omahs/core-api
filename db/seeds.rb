unless Rails.env.production?
  puts "Creating Ribon Config..."
  RibonConfig.create!(default_ticket_value: 100, minimum_integration_amount: 10,
                      default_chain_id: Web3::Providers::Networks::POLYGON[:chain_id])
  puts "Ribon Config created."

  puts "Creating non profits..."
  non_profit = NonProfit.first_or_create!(
    name: "Non Profit",
    wallet_address: "0x6E060041D62fDd76cF27c582f62983b864878E8F",
    impact_description: "1 day of impact",
  )

  non_profit.non_profit_impacts.first_or_create!(usd_cents_to_one_impact_unit: 100,
                                        start_date: "2022-01-01",
                                        end_date: "2022-09-30")
  puts "Non profits created."

  puts "Creating integrations..."
  integration = Integration.first_or_create!(
    id: 3,
    name: "Renner",
    status: 'active',
    unique_address: 'b3fa97fe-0302-4b00-97ba-df32e3060b74',
    ticket_availability_in_minutes: 30,
  )
  puts "Integrations created."

  puts "Creating integrations wallet..."
  IntegrationWallet.first_or_create!(
    public_key: "0x8927989eca54ece956e55416c92611fd3bc8dbc7",
    encrypted_private_key: "SKnTRCyhF2Jry8miqAwokdOMo0pumX1VRseodY/8tM04HTc8ENL1OVEkJqXfz/1esi5z4orsCjatZMI3aZaisiUYXA07snVBtE1BVhbuQ+4=",
    private_key_iv: "COGvFo2quFfnu0xnQMHeeQ==",
    integration: integration,
  )
  puts "Integration wallet created."
  
  puts "Creating admin..."
  Admin.first_or_create!(email: "admin@ribon.io", password: "admin123")
  puts "Admin created."

  puts "Creating test user..."
  User.first_or_create!(email: "user@test.com")
  puts "Test user created."

  puts "Creating mumbai chain..."
  Chain.first_or_create!(Web3::Providers::Networks::POLYGON)
  puts "Mumbai chain created."
end
