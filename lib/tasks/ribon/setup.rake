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

  def setup_admin
    pf 'Do you want to create a new admin? (y/n) '
    answer = gets.chomp

    if answer.downcase == 'y'
      pf 'Admin e-mail: '
      email = gets.chomp

      pf 'Admin password: '
      password = gets.chomp

      Admin.create(email:, password:)

      puts "Admin with e-mail #{email} was created!"
    end
  end

  def setup_integration_and_wallet
    pf 'Do you want to create a new integration? (y/n) '
    answer = gets.chomp

    if answer.downcase == 'y'
      pf 'Integration name: '
      name = gets.chomp

      pf 'It is an active integration? (y/n) '
      status = gets.chomp

      Integrations::CreateIntegration.call({name:, status: status == 'y' ? 'active' : 'inactive'})

      puts "Integration #{name} was created!"
      puts "The wallet #{Integration.last.integration_wallet.public_key} was associated to #{name}!"
    end
  end

  def setup_non_profit
    pf 'Do you want to create a new Non-profit? (y/n) '
    answer = gets.chomp

    if answer.downcase == 'y'
      pf 'Non-profit name: '
      name = gets.chomp

      pf 'Non-profit wallet address: (default: 0x000...)'
      wallet_address = gets.chomp

      pf 'Non-profit impact description: (default: 1 day of impact)'
      impact_description = gets.chomp

      payload = {
        name:,
        wallet_address: wallet_address.present? ? wallet_address : '0x0000000000000000000000000000000000000000',
        impact_description: impact_description.present? ? impact_description : '1 day of impact'
      }

      non_profit = NonProfit.create!(payload)

      usd_cents_to_one_impact_unit = 100
    
      non_profit.non_profit_impacts.first_or_create!(usd_cents_to_one_impact_unit:,
        start_date: "2022-01-01",
        end_date: "2022-09-30")

      puts "Non-profit #{name} was created!"
      puts "A Non-profit impact with impact unit of USD #{usd_cents_to_one_impact_unit / 100} was created!"
    end
  end

  def setup_test_user
    pf 'Do you want to create a test user? (y/n) '
    answer = gets.chomp

    if answer.downcase == 'y'
      pf 'User e-mail: '
      email = gets.chomp
      
      User.create!(email:)

      puts "User with email #{email} was created!"
    end
  end

  def pf(str)
    print str
    $stdout.flush
  end
end
