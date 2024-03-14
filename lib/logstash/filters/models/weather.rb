# frozen_string_literal: true

#
# Model of the weather
#
class Weather
  def initialize(location, temperature, metadata, weather)
    @location = location
    @temperature = temperature
    @weather_icon = metadata[:weather_icon]
    @weather_description = metadata[:weather_description]
    @wind_speed = weather[:wind_speed]
    @rain_1h = weather[:rain_1h]
    @snow_1h = weather[:snow_1h]
  end

  def to_hash
    {
      'location' => @location,
      'temperature' => @temperature,
      'weather_icon' => @weather_icon,
      'weather_description' => @weather_description,
      'wind_speed' => @wind_speed,
      'rain_1h' => @rain_1h,
      'snow_1h' => @snow_1h
    }
  end
end
