FactoryBot.define do
  factory :chain do
    name { 'Mumbai' }
    ribon_contract_address { '0xC000000000000000000000000000000000000000' }
    donation_token_contract_address { '0xD000000000000000000000000000000000000000' }
    chain_id { 0x13881 }
    rpc_url { 'https://rpc_url.com' }
    node_url { 'https://node_url.com' }
    symbol_name { 'MATIC' }
    currency_name { 'Matic' }
    block_explorer_url { 'https://block_explorer_url.com' }
  end
end
