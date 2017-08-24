class ShortenUrl < ActiveRecord::Base
  has_many :url_statistics, dependent: :destroy

  def total_stats
    self.url_statistics.group("Date(created_at)")
  end

  def daily_hourly
    self.url_statistics.where(created_at: Date.current.beginning_of_day..Date.current.end_of_day).order("created_at ASC").group("date_format(created_at, '%H:00:00')")
  end

  def daily_sum
    self.url_statistics.where(created_at: Date.current.beginning_of_day..Date.current.end_of_day).count
  end

  def daily_unique_visits
    self.url_statistics.where(created_at: Date.current.beginning_of_day..Date.current.end_of_day).order("created_at ASC").group("ip_address")
  end

  class << self
    def generate_url(original_url)
      data = find_by_original_url(original_url)
      return data if data.present?
      create_record(original_url)
    end

    def increament_total(original_url)
      data = find_by_original_url(original_url)
      data.update_attribute(:total_visit, data.total_visit + 1)
    end

    def create_record(original_url)
      return create(
        original_url: http_original_url(original_url),
        shorten_url: randomizer
      )
    end

    private

    def randomizer
      short = ""
      loop do
        short = [("a".."z"), ("A".."Z")].map(&:to_a).flatten.shuffle[0, 6].join
        return short if where(shorten_url: short).blank?
      end
    end

    def http_original_url(url)
      url.start_with?("http://", "https://") ? url : "http://#{url}"
    end
  end
end
