class UrlStatistic < ActiveRecord::Base
  class << self
    def create_record(ip, shorten_url)
      url_data = ShortenUrl.find_by_shorten_url(shorten_url)
      create(ip_address: ip, shorten_url_id: url_data.id)

      return url_data.original_url
    end

    def unique_hourly_data(data, start_period)
      record = start_period.present? ? data.url_statistics.where("created_at >= ?", DateTime.parse(start_period)) : data.url_statistics
      record.group_by{|s| s.created_at.hour}.map{ |key, value| value.uniq { |hash| hash.ip_address } }.flatten.group_by{ |s| s.created_at.strftime("%F %H") }
    end

    def unique_hourly_total(data)
      total = 0
      return total if data.blank?
      data.each do |key, values|
        total += values.count
      end
      total
    end

    def hourly_unique_visits(ip, shorten_id)
      where(created_at: Date.current.beginning_of_day..Date.current.end_of_day, shorten_url_id: shorten_id, ip_address: ip).order("created_at ASC").group("date_format(created_at, '%H:00:00')")
    end
  end
end
