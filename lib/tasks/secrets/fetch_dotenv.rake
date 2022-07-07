desc 'This task adds a user wallet for every user that does not have one'
namespace :secrets do
  task fetch_dotenv: :environment do
    puts 'Fetching .env...'
    secret = AwsSecrets::Manager.new.fetch_secret
    File.write('.env', secret)
    puts '.env fetched'
  end
end
