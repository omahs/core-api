module Formatters
  class Date
    extend ::ActionView::Helpers::DateHelper

    def self.in_words_for(date)
      return formatted_date(date) if (1.week.ago..Time.zone.now).cover?(date)

      date.strftime('%d %B')
    end

    def self.formatted_date(date)
      I18n.t('date.past', date: time_ago_in_words(date))
    end
  end
end
