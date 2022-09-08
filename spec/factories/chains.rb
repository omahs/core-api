FactoryBot.define do
  factory :chain do
    name { 'Mumbai' }
    ribon_contract_address { '0xD3850333819fBdd43784498F67010E5c87a2EAb3' }
    donation_token_contract_address { '0x21A72dc641c8e5f13717a7e087d6D63B4f9A3574' }
    chain_id { 0x13881 }
    rpc_url { 'https://rpc_url.com' }
    node_url { 'https://node_url.com' }
    symbol_name { 'MATIC' }
    currency_name { 'Matic' }
    block_explorer_url { 'https://block_explorer_url.com' }
    gas_fee_url { 'https://owlracle.info/poly/gas' }
  end
end
