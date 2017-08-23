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
  end
end
