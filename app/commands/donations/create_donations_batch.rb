# frozen_string_literal: true

module Donations
  class CreateDonationsBatch < ApplicationCommand
    prepend SimpleCommand

    def call
      create_batch_file

      create_batch
    end

    private

    def batch_donations
      Donation.left_outer_joins(:donation_batch).where('donation_batch.id': nil).distinct
    end

    def create_batch_file
      File.write("#{Rails.root}/app/lib/web3/utils/donation_batch.json", temporary_json.to_json)
    end

    def batch_file
      File.read("#{Rails.root}/app/lib/web3/utils/donation_batch.json")
    end

    def store_batch
      result = Web3::Storage::NftStorage::Actions.new.store(file: batch_file)

      OpenStruct.new(result.parsed_response).value['cid']
    end

    def temporary_json
      donations_json = []

      batch_donations.map do |donation|
        donations_json.push({
                              value: donation.value,
                              integration_id: donation.integration_id,
                              non_profit_id: donation.non_profit_id,
                              user_id: donation.user_id
                            })
      end

      donations_json
    end

    def create_batch
      Batch.create(cid: store_batch)
    end
  end
end
