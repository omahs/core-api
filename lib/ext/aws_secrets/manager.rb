module AwsSecrets
  class Manager
    attr_reader :client

    def initialize
      @client = Aws::SecretsManager::Client.new(region: region_name)
    end

    def fetch_secret
      get_secret_value_response = client.get_secret_value(secret_id: secret_name)
      get_secret_value_response.secret_string
    rescue Aws::SecretsManager::Errors::AccessDeniedException => e
      Rails.logger.debug { "You should log in the aws cli with correct credentials - error: #{e.message}" }
    rescue StandardError => e
      Rails.logger.debug e.message
    end

    def update_secret(value)
      client.update_secret({ secret_id: secret_name, secret_string: value })
    rescue Aws::SecretsManager::Errors::AccessDeniedException => e
      Rails.logger.debug { "You should log in the aws cli with correct credentials - error: #{e.message}" }
    rescue StandardError => e
      Rails.logger.debug e.message
    end

    private

    def secret_name
      'ribon-core-api-dev-dotenv'
    end

    def region_name
      'us-east-1'
    end
  end
end
