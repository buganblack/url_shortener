class Api::UrlDataController < API::BaseController
  def show
    data = ShortenUrl.find_url(params[:url])
    show_error_message(:not_found) and return unless data
    output_api(show_data(data))
  end

  def statistics
    data = ShortenUrl.find_url(params[:url])
    show_error_message(:not_found) and return unless data
    show_error_message(:invalid_params) and return if (params[:start_period].present? && (DateTime.parse(params[:start_period]) rescue nil).blank?)
    output_api(show_statistics(data))
  end

  private

  def show_data(data)
    {
      original_url: data.original_url,
      shorten_url: data.shorten_url,
      total_visit: data.total_visit
    }
  end

  # if period range is not set, default is start_period is from 1st record, end_period is current time
  def show_statistics(data)
    stats = data.url_statistics.group_by(&:ip_address)
    unique_stats = UrlStatistic.unique_hourly_data(data, params[:start_period])
    {
      total_visit: data.total_visit,
      total_visitor: data.url_statistics.count,
      visitor_data: stats.map { |ip, record| { ip: ip, total_visits: record.count } },
      unique_hourly_data: unique_stats,
      uniqie_hourly_total: UrlStatistic.unique_hourly_total(unique_stats)
    }
  end
end
