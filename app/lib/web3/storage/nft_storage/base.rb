module Web3
  module Storage
    module NftStorage
      class Base
        require 'nft_storage'

        def initialize
          NFTStorage.configure do |config|
            config.access_token = RibonCoreApi.config[:web3][:nft_storage][:nft_storage_api_key]
          end
        end

        def api_instance
          NFTStorage::NFTStorageAPI.new
        end
      end
    end
  end
end
