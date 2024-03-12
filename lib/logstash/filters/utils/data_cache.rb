class WeatherDataCache
  def initialize(memcached_servers)
    @memcached = Dalli::Client.new(memcached_servers)
  end

  def cache_weather_data(key, weather_data)
    @memcached.set(key, weather_data)
  end

  def fetch_cached_weather_data(key)
    @memcached.get(key)
  end
end
