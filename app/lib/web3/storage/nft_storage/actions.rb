module Web3
  module Storage
    module NftStorage
      class Actions < Base
        def delete(cid:)
          Web3::Storage::NftStorage::Base.new.delete(cid:)
        rescue StandardError => e
          Rails.logger.debug { "Exception when calling NFTStorageAPI->delete: #{e}" }
        end

        def list
          Web3::Storage::NftStorage::Base.new.list
        rescue StandardError => e
          Rails.logger.debug { "Error when calling NFTStorageAPI->list: #{e}" }
        end

        def store(file:)
          Web3::Storage::NftStorage::Base.new.store(file:)
        rescue StandardError => e
          Rails.logger.debug { "Error when calling NFTStorageAPI->store: #{e}" }
        end
      end
    end
  end
end
