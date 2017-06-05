class GoogleMapService
  def initialize(params)
    @begin_lat = params[:begin_lat]
    @begin_long = params[:begin_long]
    @end_lat = params[:end_lat]
    @end_long = params[:end_long]
    @result = []
  end

  def perform
    response = get_data
    parsed_response = JSON.parse(response).with_indifferent_access
    extract_data(parsed_response)
  rescue StandardError => e
    { error: e }
  end

  def get_data
    uri = URI(api_url)
    uri.query = URI.encode_www_form(request_params)
    result = Net::HTTP.get_response(uri)
    return result.body if result.is_a?(Net::HTTPSuccess)
    raise_error('request')
  end

  def extract_data(response)
    raise_error('no_info') if response[:status] == 'ZERO_RESULTS'
    response[:routes].each do |route|
      route[:legs].each do |leg|
        @result << {
          distance: prepare_data(leg[:distance][:text]),
          time: prepare_data(leg[:duration][:text])
        }
      end
    end
    @result
  end

  def request_params
    {
      origin: prepare_point(@begin_lat, @begin_long),
      destination: prepare_point(@end_lat, @end_long),
      language: 'ru',
      mode: 'DRIVING',
      alternatives: true,
      key: api_key
    }
  end

  def prepare_data(data)
    data.split(' ').first
  end

  def prepare_point(lat, long)
    [lat, long].join(',')
  end

  def api_url
    Rails.configuration.google_api_url
  end

  def api_key
    Rails.configuration.api_key
  end

  def raise_error(text)
    raise StandardError.new(I18n.t("google_maps.error.#{text}"))
  end
end
