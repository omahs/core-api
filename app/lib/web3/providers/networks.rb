module Web3
  module Providers
    class Networks
      MUMBAI = {
        chain_name: 'Mumbai Testnet',
        ribon_contract_address: '0x38D30f5123e774E26D60C02d4B2927b90953E3d5',
        donation_token_contract_address: '0x21A72dc641c8e5f13717a7e087d6D63B4f9A3574',
        chain_id: 0x13881,
        rpc_urls: 'https://rpc-mumbai.maticvigil.com',
        node_url: 'https://polygon-mumbai.g.alchemy.com/v2/iwJOj0NGGqgpYpyCJxt3dZzu9wOMACg_',
        symbol_name: 'MATIC',
        currency_name: 'Matic',
        block_explorer_urls: 'https://mumbai.polygonscan.com/'
      }.freeze
      LOCAL = {
        chain_name: 'Localhost 8545',
        ribon_contract_address: '0x5FbDB2315678afecb367f032d93F642f64180aa3',
        donation_token_contract_address: '0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512',
        chain_id: 0x539,
        rpc_urls: 'http://localhost:8545',
        node_url: 'http://localhost:8545',
        symbol_name: 'ETH',
        currency_name: 'Ether',
        block_explorer_urls: 'http://localhost:8545'
      }.freeze
    end
  end
end
