class ShortenUrl < ActiveRecord::Base

  class << self
    def generate_url(original_url)
      data = find_by_original_url(original_url)
      return data if data.present?
      create_record(original_url)
    end

    private

    def create_record(original_url)
      return self.create(
        original_url: original_url,
        shorten_url: randomizer
      )
    end

    def randomizer
      short = ""
      loop do
        short = [("a".."z"), ("A".."Z")].map(&:to_a).flatten.shuffle[0, 6].join
        return short if where(shorten_url: short).blank?
      end
    end
  end
end
