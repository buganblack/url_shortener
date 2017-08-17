class ShortenUrlController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: ShortenUrl.generate_url(params[:url]) }
    end
  end

  def redirect
  end
end
