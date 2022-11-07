module Tracking
  class AddUtm < ApplicationCommand
    prepend SimpleCommand

    attr_reader :utm, :utm_source, :utm_medium, :utm_campaign, :trackable

    def initialize(utm_source:, utm_medium:, utm_campaign:, trackable:)
      @utm_source = utm_source
      @utm_medium = utm_medium
      @utm_campaign = utm_campaign
      @trackable = trackable
    end

    def call
      ActiveRecord::Base.transaction do
        @utm = trackable.create_utm!(utm_params) if trackable.utm.nil? && valid_params?
      end

      @result = utm
      self
    rescue StandardError => e
      Reporter.log(error: e, extra: { message: e.message })
    end

    private

    def valid_params?
      utm_source && utm_medium && utm_campaign
    end

    def utm_params
      {
        source: utm_source,
        medium: utm_medium,
        campaign: utm_campaign
      }
    end
  end
end
