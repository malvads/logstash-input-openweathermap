# frozen_string_literal: true

#
# Model of the weather
#
class Weather
  def initialize(location, temperature, metadata, wind_speed = 0, rain_1h = 0, snow_1h = 0)
    @location = location
    @temperature = temperature
    @weather_icon = metadata[:weather_icon]
    @weather_description = metadata[:weather_description]
    @wind_speed = wind_speed
    @rain_1h = rain_1h
    @snow_1h = snow_1h
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
