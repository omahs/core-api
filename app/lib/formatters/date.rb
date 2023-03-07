module Formatters
  class Date
    extend ::ActionView::Helpers::DateHelper

    ONE_WEEK_INTERVAL = 1.week.ago..Time.zone.now

    def self.in_words_for(date)
      return formatted_date(date) if ONE_WEEK_INTERVAL.cover?(date)

      date.strftime('%d %B')
    end

    def self.formatted_date(date)
      I18n.t('date.past', date: time_ago_in_words(date))
    end
  end
end
