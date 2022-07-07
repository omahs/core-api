desc 'This task adds a user wallet for every user that does not have one'
namespace :secrets do
  task update_dotenv: :environment do
    puts 'Updating .env...'
    secret = File.read('.env')
    AwsSecrets::Manager.new.update_secret(secret)
    puts '.env updated'
  end
end
