module Formatters
  class Date
    extend ::ActionView::Helpers::DateHelper

    def self.one_week_interval
      1.week.ago..Time.zone.now
    end

    def self.in_words_for(date)
      return formatted_date(date) if ONE_WEEK_INTERVAL.cover?(date)

      date.strftime('%d %B')
    end

    def self.formatted_date(date)
      I18n.t('date.past', date: time_ago_in_words(date))
    end
  end
end
