FactoryBot.define do
  factory :token do
    name { 'USDC' }
    address { '0xF000000000000000000000000000000000000000' }
    decimals { 6 }
    chain { build(:chain) }
  end
end
