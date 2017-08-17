class ShortenUrlController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json { render json: ShortenUrl.generate_url(params[:url]) }
    end
  end

  def redirect
    original_url = UrlStatistic.create_record(request.remote_ip, params[:shorten_url])

    original_url = "http://#{original_url}" unless original_url.start_with?("http://", "https://")

    redirect_to(original_url)
  end
end
