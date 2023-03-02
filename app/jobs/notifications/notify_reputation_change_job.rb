# frozen_string_literal: true

module Notifications
  class NotifyReputationChangeJob < ApplicationJob
    queue_as :default
    sidekiq_options retry: 3

    def perform(badge_id:, user_id:, granted_at:)
      puts "Send email of first donation" if badge_id == 1

      badge = Badge.find_by(merit_badge_id: badge_id)
      user = User.find(user_id)
      puts "You just granted #{badge.name}. #{badge.description}. You are #{user.email}. You gained it at #{granted_at.strftime("%d/%m/%Y")}"
    end
  end
end
