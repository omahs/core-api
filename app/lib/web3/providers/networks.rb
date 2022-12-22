module Web3
  module Providers
    class Networks
      config = RibonCoreApi.config[:web3][:networks]

      POLYGON = {
        name: 'Polygon Mainnet',
        ribon_contract_address: '0x4Ef236DA69ac23a9246cd1d8866264f1A95601C0',
        donation_token_contract_address: '0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174',
        chain_id: 0x89,
        rpc_url: config[:polygon][:rpc_url],
        node_url: config[:polygon][:node_url],
        symbol_name: 'MATIC',
        currency_name: 'Matic',
        block_explorer_url: config[:polygon][:block_explorer_url]
      }.freeze

      MUMBAI = {
        name: 'Mumbai Testnet',
        ribon_contract_address: '0x348eA4886c5F0926d7A6Ad6C5CF6dFA4F88CA9Bf',
        donation_token_contract_address: '0x21A72dc641c8e5f13717a7e087d6D63B4f9A3574',
        chain_id: 0x13881,
        rpc_url: config[:mumbai][:rpc_url],
        node_url: config[:mumbai][:node_url],
        symbol_name: 'MATIC',
        currency_name: 'Matic',
        block_explorer_url: config[:mumbai][:block_explorer_url]
      }.freeze

      LOCAL = {
        name: 'Localhost 8545',
        ribon_contract_address: '0x5FbDB2315678afecb367f032d93F642f64180aa3',
        donation_token_contract_address: '0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512',
        chain_id: 0x539,
        rpc_url: 'http://localhost:8545',
        node_url: 'http://localhost:8545',
        symbol_name: 'ETH',
        currency_name: 'Ether',
        block_explorer_url: 'http://localhost:8545'
      }.freeze
    end
  end
end
