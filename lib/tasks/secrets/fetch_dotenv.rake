def fetch_secret
  secret_name = 'ribon-core-api-dev-dotenv'
  region_name = 'us-east-1'
  client = Aws::SecretsManager::Client.new(region: region_name)

  get_secret_value_response = client.get_secret_value(secret_id: secret_name)
  secret = get_secret_value_response.secret_string

  File.write('.env', secret)
rescue Aws::SecretsManager::Errors::AccessDeniedException => e
  puts "You should log in the aws cli with correct credentials - error: #{e.message}"
rescue StandardError => e
  puts e.message
end

desc 'This task adds a user wallet for every user that does not have one'
namespace :secrets do
  task fetch_dotenv: :environment do
    puts 'Fetching .env...'
    fetch_secret
    puts '.env fetched'
  end
end
