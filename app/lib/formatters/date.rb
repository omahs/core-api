module Formatters
  class Date
    def self.in_words_for(start_time)
      difference_in_minutes = ((Time.zone.now - start_time) / 60).round
      
      case difference_in_minutes
      when 0
        I18n.t('date.time_units.half_minute')
      when 1..59
        pluralize(difference_in_minutes, 'minute')
      when 60..1439
        pluralize((difference_in_minutes / 60), 'hour')
      when 1440..10079
        pluralize((difference_in_minutes / 1440), 'day')
      else
        pluralize((difference_in_minutes / 10080), 'week')
      end
    end

    private

    def self.pluralize(count, singular)
      key = count == 1 ? singular : singular.pluralize
    
      "#{count} #{I18n.t("date.time_units.#{key}")}"
    end
  end
end
