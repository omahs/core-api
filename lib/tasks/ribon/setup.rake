desc 'This task helps the user to create some dummy data on local environment'
namespace :ribon do
  task setup: :environment do
    puts 'Welcome to the Ribon Core API setup'
    puts 'Now we are going to create some customized entities.'
    puts ''

    setup_admin
    setup_integration_and_wallet
    setup_non_profit
    setup_test_user
  end
end

def setup_admin
  return unless can_create?('admin')

  pf 'Admin e-mail: '
  email = gets.chomp

  pf 'Admin password: '
  password = gets.chomp

  Admin.create(email:, password:)

  puts "Admin with e-mail #{email} was created!"
end

def setup_integration_and_wallet
  return unless can_create?('integration')

  pf 'Integration name: '
  name = gets.chomp

  pf 'It is an active integration? (y/n) '
  status = gets.chomp

  Integrations::CreateIntegration.call({ name:, status: status == 'y' ? 'active' : 'inactive' })

  puts "Integration #{name} was created!"
  puts "The wallet #{Integration.last.integration_wallet.public_key} was associated to #{name}!"
end

def setup_non_profit
  return unless can_create?('non-profit')

  pf 'Non-profit name: '
  name = gets.chomp

  pf 'Non-profit wallet address: (default: 0x000...)'
  wallet_address = gets.chomp

  non_profit = NonProfit.create!({
                                   name:, wallet_address: wallet_address.presence ||
                                   '0x0000000000000000000000000000000000000000'
                                 })

  non_profit.non_profit_impacts.first_or_create!(usd_cents_to_one_impact_unit: 100,
                                                 start_date: '2022-01-01', end_date: '2022-09-30')

  puts "Non-profit #{name} with impact unit of USD 1.00 was created!"
end

def setup_test_user
  return unless can_create?('test user')

  pf 'User e-mail: '
  email = gets.chomp

  User.create!(email:)

  puts "User with email #{email} was created!"
end

def can_create?(entity_name)
  pf "Do you want to create a new #{entity_name}? (y/n) "

  gets.chomp.casecmp('y').zero?
end

def pf(str)
  print str
  $stdout.flush
end
