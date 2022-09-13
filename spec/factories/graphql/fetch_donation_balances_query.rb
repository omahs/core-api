class FetchDonationBalancesQuery
  attr_accessor :data, :errors, :extensions, :original_hash
end

FactoryBot.define do
  factory :fetch_donation_balances_query do
    data { '' }
    errors { '' }
    extensions { '' }
    original_hash do
      {
        'data' => {
          'donationBalances' =>
            [{ 'id' => '0x01',
               'integration' => '0xB000000000000000000000000000000000000000',
               'totalDonated' => '17000000000000000000',
               'nonProfit' => '0xA000000000000000000000000000000000000000',
               'user' => '0xa862a74feda5a9d7491cccb64b94e4fe91e890fdadca205eefd35dbc2d4d349a' },
             { 'id' => '0x02',
               'integration' => '0xB111111111111111111111111111111111111111',
               'totalDonated' => '1000000000000000000',
               'nonProfit' => '0xA111111111111111111111111111111111111111',
               'user' => '0xa862a74feda5a9d7491cccb64b94e4fe91e890fdadca205eefd35dbc2d4d349a' },
             { 'id' => '0x02',
               'integration' => '0xB222222222222222222222222222222222222222',
               'totalDonated' => '1000000000000000000',
               'nonProfit' => '0xA222222222222222222222222222222222222222',
               'user' => '0xa862a74feda5a9d7491cccb64b94e4fe91e890fdadca205eefd35dbc2d4d349a' }]
        }
      }
    end
  end
end
