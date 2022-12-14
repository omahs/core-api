# frozen_string_literal: true

module Donations
  class CreateDonationsBatch < ApplicationCommand
    prepend SimpleCommand
    attr_reader :integration, :non_profit

    def initialize(integration:, non_profit:)
      @integration = integration
      @non_profit = non_profit
    end

    def call
      return unless batch_donations.length.positive?

      create_batch_file

      batch = create_batch
      create_donations_batch(batch)
      batch
    end

    private

    def batch_donations
      Donation.where(integration:,
                     non_profit:).left_outer_joins(:donation_batch).where('donation_batch.id': nil).distinct
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

    # rubocop:disable Metrics/MethodLength
    def temporary_json
      donations_json = []

      batch_donations.map do |donation|
        donations_json.push({
                              value: donation.value,
                              integration_id: donation.integration_id,
                              non_profit_id: donation.non_profit_id,
                              user_id: donation.user_id,
                              donation_id: donation.id,
                              user_hash: user_hash(donation.user.email),
                              integration_address: donation.integration.integration_address,
                              non_profit_address: donation.non_profit.wallet_address,
                              timestamp: donation.created_at
                            })
      end

      donations_json
    end
    # rubocop:enable Metrics/MethodLength

    def create_batch
      Batch.create(cid: store_batch, amount: total_amount)
    end

    def create_donations_batch(batch)
      batch_donations.map do |donation|
        DonationBatch.create(donation:, batch:)
      end
    end

    def total_amount
      amount = 0
      batch_donations.map do |donation|
        amount += donation.value || 0
      end
      amount
    end

    def user_hash(email)
      Web3::Utils::Converter.keccak(email)
    end
  end
end