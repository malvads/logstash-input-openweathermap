# frozen_string_literal: true

#
# Class to manage OpenWeatherMap API calls
#
class WeatherDataFetcher
  def initialize(api_key)
    @api_key = api_key
  end

  def fetch_weather_data(lat, lon)
    url = "https://api.openweathermap.org/data/2.5/weather?lat=#{@lat}&lon=#{@lon}&appid=#{@api_key}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)

    return unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body)
  end
end
