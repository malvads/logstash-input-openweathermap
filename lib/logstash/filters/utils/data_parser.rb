# frozen_string_literal: true

#
# Class to parse the data that comes from the OpenWeatherMap API
#
class WeatherDataParser
  def parse(weather_data)
    @metadata = {}
    @weather = {}
    @location = weather_data['name']
    @temperature = weather_data.dig('main', 'temp') || 0
    @metadata[:weather_icon] = weather_data.dig('weather', 0, 'icon') || ''
    @metadata[:weather_description] = weather_data.dig('weather', 0, 'description') || ''
    @weather[:wind_speed] = weather_data.dig('wind', 'speed') || 0
    @weather[:wind_deg] = weather_data.dig('wind', 'deg') || 0
    @weather[:rain_1h] = weather_data.dig('rain', '1h') || 0
    @weather[:snow_1h] = weather_data.dig('snow', '1h') || 0
    create_model
  end

  def create_model
    Weather.new(
      @location,
      @temperature,
      @metadata,
      @weather
    ).to_hash
  end
end
