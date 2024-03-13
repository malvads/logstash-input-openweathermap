# frozen_string_literal: true

#
# Class to parse the data that comes from the OpenWeatherMap API
#
class WeatherDataParser
  def parse(weather_data)
    @metadata = {}
    @location = weather_data['name']
    @temperature = weather_data.dig('main', 'temp') || 0
    @metadata[:weather_icon] = weather_data.dig('weather', 0, 'icon') || ''
    @metadata[:weather_description] = weather_data.dig('weather', 0, 'description') || ''
    @wind_speed = weather_data.dig('wind', 'speed') || 0
    @rain_1h = weather_data.dig('rain', '1h') || 0
    create_model
  end

  def create_model
    Weather.new(
      @location,
      @temperature,
      @metadata,
      @wind_speed,
      @rain_1h
    ).to_hash
  end
end
