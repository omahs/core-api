FactoryBot.define do
  factory :chain do
    name { 'MyString' }
    ribon_contract_address { 'MyString' }
    donation_token_contract_address { 'MyString' }
    chain_id { 1 }
    rpc_url { 'MyString' }
    node_url { 'MyString' }
    symbol_name { 'MyString' }
    currency_name { 'MyString' }
    block_explorer_url { 'MyString' }
  end
end
