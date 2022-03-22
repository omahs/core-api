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
  image_path = Rails.root.join('vendor/assets/ribon_logo.png')

  integration = Integration.first_or_initialize(
    name: "Renner",
    wallet_address: "0x6E060041D62fDd76cF27c582f62983b864878E8F",
    url: "https://www.lojasrenner.com.br/",
  )
  integration.logo.attach(io: File.open(image_path),
                          filename: 'ribon_logo.png',
                          content_type: 'image/png')
  integration.save!
  puts "Integrations created."

  puts "Creating admin..."
  Admin.first_or_create!(
    email: "admin@ribon.io",
    password: "admin123",
  )
  puts "Admin created."

  puts "Creating test user..."
  User.first_or_create!(
    email: "user@test.com",
  )
  puts "Test user created."

end
