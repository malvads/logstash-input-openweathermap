class WeatherDataParser
  def parse(weather_data)
    parsed_data = {
      'location' => weather_data['name'],
      'temperature' => weather_data['main']['temp'],
      'weather_icon' => weather_data['weather'][0]['icon'],
      'weather_description' => weather_data['weather'][0]['description']
    }

    parsed_data['wind_speed'] = weather_data['wind'] ? weather_data['wind']['speed'] : 0
    parsed_data['rain_1h'] = weather_data['rain'] && weather_data['rain']['1h'] ? weather_data['rain']['1h'] : 0

    parsed_data
  end
end
