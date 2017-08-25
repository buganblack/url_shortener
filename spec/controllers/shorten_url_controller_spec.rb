require "spec_helper"

describe ShortenUrlController do

  describe "#redirect", type: :controller do
    it "when params is valid" do
      url_record = ShortenUrl.create_record(SecureRandom.hex(10))
      valid_params = { shorten_url: url_record.shorten_url }
      get "redirect", valid_params

      expect(UrlStatistic.last.shorten_url_id).to eq(url_record.id)
      expect(ShortenUrl.last.total_visit).to be > 0
      expect(response).to redirect_to(url_record.original_url)
    end

    it "when params is not valid" do
      invalid_params = { shorten_url: "123" }
      get "redirect", invalid_params

      expect(response.status).to eq(404)
    end
  end

  describe "#show_statistics", type: :controller do
    it "when params is a valid" do
      get "show_statistics", { url: ShortenUrl.last.shorten_url }

      expect(response.status).to eq(200)
      expect(response).to render_template(:show_statistics)
    end

    it "when params is a not valid" do
      get "show_statistics", { url: "123" }

      expect(response.status).to eq(404)
    end
  end
end
