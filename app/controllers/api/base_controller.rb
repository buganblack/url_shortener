class API::BaseController < ApplicationController
  before_filter :validate_key_format

  API_KEY = "123test123"

  RESULT = {
    ok: {
      code: 0,
      message: "OK!"
    },
    invalid_params: {
      code: 100,
      message: "Request parameter invalid!"
    },
    not_found: {
      code: 101,
      message: "Not found!"
    }
  }

  def output_api(result = {})
    render json: default_format.merge(result)
  end

  protected

  def show_error_message(key)
    render json: default_format(key)
  end

  def default_format(key = "ok")
    result = RESULT[key.to_sym]
    {
      result_code: result[:code],
      result_message: result[:message]
    }
  end

  private

  def validate_key_format
    return if params[:format] == "json" && API_KEY == params[:key]
    show_error_message(:invalid_params)
  end
end
