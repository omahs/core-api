module Web3
  module Storage
    module NftStorage
      class Actions < Base
        def delete(cid:)
          api_instance.delete(cid)
        rescue NFTStorage::ApiError => e
          Rails.logger.debug { "Exception when calling NFTStorageAPI->delete: #{e}" }
        end

        def list
          api_instance.list(list_options)
        rescue NFTStorage::ApiError => e
          Rails.logger.debug { "Error when calling NFTStorageAPI->list: #{e}" }
        end

        def status(cid:)
          api_instance.status(cid)
        rescue NFTStorage::ApiError => e
          Rails.logger.debug { "Error when calling NFTStorageAPI->status: #{e}" }
        end

        def store
          body = File.read("#{Rails.root}/app/lib/web3/utils/abis/ribon_abi.json")

          api_instance.store(body)
        rescue NFTStorage::ApiError => e
          Rails.logger.debug { "Error when calling NFTStorageAPI->store: #{e}" }
        end

        private

        def list_options
          { limit: 1000 }
        end
      end
    end
  end
end
