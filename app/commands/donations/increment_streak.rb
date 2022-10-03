# frozen_string_literal: true

module Donations
  class IncrementStreak < ApplicationCommand
    prepend SimpleCommand
    attr_reader :donation

    INCREMENT_VALUE = 1
    RESET_STREAK_VALUE = 0

    def initialize(donation:)
      @donation = donation
    end

    def call
      user.user_donation_stats.update!(donation_streak: streak)
    end

    private

    def streak
      last_donation_at = user.user_donation_stats.last_donation_at.to_date
      current_streak = user.user_donation_stats.donation_streak

      return current_streak if last_donation_at == Time.zone.today
      return current_streak + INCREMENT_VALUE if last_donation_at == Time.zone.yesterday

      RESET_STREAK_VALUE if last_donation_at < Time.zone.yesterday
    end

    def user
      @user ||= donation.user
    end
  end
end
