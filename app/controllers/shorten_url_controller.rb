class ShortenUrlController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json { render json: ShortenUrl.generate_url(params[:url]) }
    end
  end

  def redirect
    url = UrlStatistic.create_record(request.remote_ip, params[:shorten_url])

    ShortenUrl.increament_total(url) if url.present?

    redirect_to(url)
  end

  def show_statistics
    @data = ShortenUrl.find_by_shorten_url(params[:url])
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404 and return unless @data
  end
end
