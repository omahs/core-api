FactoryBot.define do
  factory :donation do
    non_profit { build(:non_profit) }
    integration { build(:integration) }
    blockchain_process_link { 'https://etherscan.io/0x091203' }
  end
end
