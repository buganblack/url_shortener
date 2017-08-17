class UrlStatistic < ActiveRecord::Base

  class << self
    def create_record(ip, shorten_url)
      url_data = ShortenUrl.find_by_shorten_url(shorten_url)
      statistic_data = url_data.url_statistics.select { |data| data.ip_address == ip }.first
      if statistic_data.present?
        statistic_data.update_attribute(:visit, statistic_data.visit + 1)
      else
        create(ip_address: ip, visit: 1, shorten_url_id: url_data.id)
      end

      return url_data.original_url
    end
  end
end
