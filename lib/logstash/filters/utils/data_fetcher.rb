# frozen_string_literal: true

#
# Class to manage OpenWeatherMap API calls
#
class WeatherDataFetcher
  def initialize(api_key)
    @api_key = api_key
  end

  def fetch_weather_data(lat, lon)
    url = "https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&appid=#{@api_key}"
    uri = URI.parse(url)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    response = http.get(uri.request_uri)
    JSON.parse(response.body)
  rescue StandardError
    {}
  end
end
