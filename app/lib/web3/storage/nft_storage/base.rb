module Web3
  module Storage
    module NftStorage
      class Base
        def delete(cid:)
          Request::ApiRequest.delete("#{base_url}/#{cid}", headers:)
        end

        def list
          Request::ApiRequest.get(base_url, headers:)
        end

        def store(file:)
          HTTParty.post("#{base_url}/upload", body: file, headers:)
        end

        private

        def token
          RibonCoreApi.config[:web3][:nft_storage][:nft_storage_api_key]
        end

        def base_url
          'https://api.nft.storage'
        end

        def headers
          {
            Authorization: "Bearer #{token}",
            'Content-Type': 'application/json'
          }
        end
      end
    end
  end
end
