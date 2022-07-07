def get_secret
  secret_name = "ribon-core-api-dev-dotenv"
  region_name = "us-east-1"

  client = Aws::SecretsManager::Client.new(region: region_name)

  begin
    get_secret_value_response = client.get_secret_value(secret_id: secret_name)
  rescue Aws::SecretsManager::Errors::DecryptionFailure => e
    puts e.message
  rescue Aws::SecretsManager::Errors::InternalServiceError => e
    puts e.message
  rescue Aws::SecretsManager::Errors::InvalidParameterException => e
    puts e.message
  rescue Aws::SecretsManager::Errors::InvalidRequestException => e
    puts e.message
  rescue Aws::SecretsManager::Errors::ResourceNotFoundException => e
    puts e.message
  rescue Aws::SecretsManager::Errors::AccessDeniedException => e
    puts "You should log in the aws cli with correct credentials - error: #{e.message}"
  else
    secret = get_secret_value_response.secret_string

    File.open('.env', 'w') { |file| file.write(secret) }
  end
end

desc 'This task adds a user wallet for every user that does not have one'
namespace :secrets do
  task fetch_dotenv: :environment do
    puts 'Fetching .env...'
    get_secret
    puts '.env fetched'
  end
end
