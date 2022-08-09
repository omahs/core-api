unless Rails.env.production?
  puts "Creating non profits..."
  non_profit = NonProfit.first_or_create!(
    name: "Non Profit",
    wallet_address: "0xF20c382d2A95EB19f9164435aed59E5C59bc1fd9",
    impact_description: "1 day of impact",
  )

  non_profit.non_profit_impacts.first_or_create!(usd_cents_to_one_impact_unit: 100,
                                        start_date: "2022-01-01",
                                        end_date: "2022-09-30")
  puts "Non profits created."

  puts "Creating integrations..."
  integration = Integration.first_or_create!(
    name: "Renner",
    status: 'active',
    unique_address: 'b3fa97fe-0302-4b00-97ba-df32e3060b74',
    ticket_availability_in_minutes: 30,
  )
  puts "Integrations created."

  puts "Creating integrations wallet..."
  IntegrationWallet.first_or_create!(
    public_key: "0xffffffffffffffffffffffffffffffffffffffff",
    encrypted_private_key: "dGhpcyBpcyBhbiBlbmNyeXB0ZWQgcHJpdmF0ZSBrZXkgdXNpbmcgb3BlbnNzbCBhbmQgdGhlbiBlbmNvZGVkIHdpdGggYmFzZTY0",
    private_key_iv: "dGhpcyBpcyBhIHByaXZhdGUga2V5IGl2IGVuY29kZWQgd2l0aCBiYXNlNjQ=",
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
  Chain.first_or_create!(Web3::Providers::Networks::MUMBAI)
  puts "Mumbai chain created."
end
