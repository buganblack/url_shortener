class ShortenUrl < ActiveRecord::Base
  has_many :url_statistics, dependent: :destroy

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
        original_url: original_url,
        shorten_url: randomizer
      )
    end

    def find_url(url)
      where("shorten_url = ? OR original_url LIKE ?", url, "%#{url}%").first
    end

    private

    def randomizer
      short = ""
      loop do
        short = [("a".."z"), ("A".."Z")].map(&:to_a).flatten.shuffle[0, 6].join
        return short if where(shorten_url: short).blank?
      end
    end
  end
end
