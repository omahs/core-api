# frozen_string_literal: true

module Mailers
  class CheckForContributionReactivation
    def perform
      users = User.users_that_last_contributed_in(1.month.ago)

      users.each do |user|
        SendContributionReactivationEmailJob.perform_later(user:)
      end
    end
  end
end

