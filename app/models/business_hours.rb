# Define business hours
class BusinessHours
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  BUSINESS_DAYS = Date::ABBR_DAYNAMES.collect { |day| day.downcase.to_sym }
  TIME_INTERVAL = Array.new(24.hours / 30.minutes) do |i|
                    (Time.now.midnight + (i * 30.minutes)).strftime('%H:%M')
                  end
  attr_accessor :sun, :mon, :tue, :wed, :thu, :fri, :sat


  # serialize :business_hours, BusinessHours

  def self.load(json)
    obj = self.new
    unless json.nil?
      attrs = JSON.parse json
      BUSINESS_DAYS.each do |day|
        obj.send("#{day}=", attrs[day.to_s].deep_symbolize_keys)
      end
    end
    obj
  end

  def self.dump(obj)
    obj.to_json
  end

  def simplify
    days_hash = {}
    self.as_json.to_options.each do |day, times|
      days_hash[day] = times.values.join('-')
    end
    days_hash_inverse = {}
    days_hash.each do |day, times|
      if days_hash_inverse.has_key?(times)
        days_hash_inverse[times] = "#{days_hash_inverse[times]}, #{day.capitalize}"
      else
        days_hash_inverse[times] = "#{day.capitalize}"
      end
    end
    days_hash_inverse.invert
  end

  def earlierst_opening_hour_int
    opening_hours = Array.new
    self.as_json.to_options.each do |day, times|
      return if times["cloased"] == "1"
      opening_hours << Time.parse("1970-01-01 #{times["start"]} UTC").to_i
    end
    opening_hours.sort!
    opening_hours.empty? ? Time.parse('1970-01-01 23:59:59 UTC').to_i : opening_hours.first
  end

  def to_s
    business_hours_string = ''
    simplify.each do |days, times|
      business_hours_string.insert(-1, "#{days}: #{times}; \n")
    end
    business_hours_string.empty? ? I18n.t('business_hours.not_defined') : business_hours_string.chomp(';')
  end
end
