# frozen_string_literal: true

#
# Weather model for store and manipulate weather data
#
class Weather < BaseModel
  def initialize(location, temperature, metadata, weather)
    super()
    @location = location
    @temperature = temperature
    @weather_icon = metadata[:weather_icon]
    @weather_description = metadata[:weather_description]
    @wind_speed = weather[:wind_speed]
    @rain_1h = weather[:rain_1h]
    @snow_1h = weather[:snow_1h]
    kelvin_to_celcius
  end

  private

  def kelvin_to_celcius
    @temperature -= 273.15
  end
end
