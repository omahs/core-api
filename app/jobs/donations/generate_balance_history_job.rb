module Donations
  class GenerateBalanceHistoryJob < ApplicationJob
    queue_as :default
    sidekiq_options retry: 3

    def perform(pool:)
      Service::Donations::BalanceHistory.new(pool:).add_balance
    end
  end
end
