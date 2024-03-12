class WeatherDataParser
  def parse(weather_data)
    {
      'location' => weather_data['name'],
      'humidity' => weather_data['main']['humidity'],
      'temperature' => weather_data['main']['temp'],
      'weather_icon' => weather_data['weather'][0]['icon'],
      'weather_description' => weather_data['weather'][0]['description'],
      'wind_speed' => weather_data['wind']['speed'] # meters per second
    }
  end
end
