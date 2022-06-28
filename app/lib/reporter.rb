# frozen_string_literal: true

class Reporter
  def self.log(error:, extra: {}, level: :error)
    if Rails.env.production?
      Sentry.capture_exception(error, level:, extra:)
    else
      Rails.logger.info(error)
      Rails.logger.info(extra)
    end
  end
end
