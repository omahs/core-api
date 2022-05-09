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
               'integration' => '0x6e060041d62fdd76cf27c582f62983b864878e8f',
               'totalDonated' => '17000000000000000000',
               'nonProfit' => '0xf20c382d2a95eb19f9164435aed59e5c59bc1fd9',
               'user' => '0xa862a74feda5a9d7491cccb64b94e4fe91e890fdadca205eefd35dbc2d4d349a' },
             { 'id' => '0x02',
               'integration' => '0x6e060041d62fdd76cf27c582f62983b864878e8f',
               'totalDonated' => '1000000000000000000',
               'nonProfit' => '0xf20c382d2a95eb19f9164435aed59e5c59bc1fd9',
               'user' => '0xa862a74feda5a9d7491cccb64b94e4fe91e890fdadca205eefd35dbc2d4d349a' },
             { 'id' => '0x02',
               'integration' => '0x6e060041d62fdd76cf27c582f62983b864878e8f',
               'totalDonated' => '1000000000000000000',
               'nonProfit' => '0xg20c382d2a95eb19f9164435aed59e5c59bc1fd9',
               'user' => '0xa862a74feda5a9d7491cccb64b94e4fe91e890fdadca205eefd35dbc2d4d349a' }]
        }
      }
    end
  end
end
