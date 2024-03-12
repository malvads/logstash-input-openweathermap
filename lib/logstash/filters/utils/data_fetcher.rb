class WeatherDataFetcher
  def initialize(latitude, longitude, api_key)
    @latitude = latitude
    @longitude = longitude
    @api_key = api_key
  end

  def fetch_weather_data
    url = "https://api.openweathermap.org/data/2.5/weather?lat=#{@latitude}&lon=#{@longitude}&appid=#{@api_key}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      nil
    end
  end
end
