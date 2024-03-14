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
    instance_variables.each_with_object({}) { |var, hash| hash[var.to_s.delete('@')] = instance_variable_get(var) }
  end
end
