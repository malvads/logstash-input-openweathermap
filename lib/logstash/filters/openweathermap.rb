# logstash-filter-openweathermap.rb

require 'logstash/filters/base'
require 'logstash/namespace'
require 'net/http'
require 'json'
require 'dalli'

require_relative "util/memcached_config"
require_relative "util/data_parser"
require_relative "util/data_cache"
require_relative "util/data_fetcher"


class LogStash::Filters::OpenWeatherMap < LogStash::Filters::Base
  config_name 'openweathermap'

  # Define configuration options
  config :latitude, :validate => :number, :required => true
  config :longitude, :validate => :number, :required => true
  config :api_key, :validate => :string, :required => true

  def register
    @memcached_servers = @memcached_servers || MemcachedConfig::servers
    @weather_data_fetcher = WeatherDataFetcher.new(@latitude, @longitude, @api_key)
    @weather_data_parser = WeatherDataParser.new
    @weather_data_cache = WeatherDataCache.new(@memcached_servers)
  end

  def filter(event)
    cached_weather_data = @weather_data_cache.fetch_cached_weather_data(cache_key)

    if cached_weather_data
      weather_fields = cached_weather_data
    else
      weather_data = @weather_data_fetcher.fetch_weather_data

      if weather_data
        weather_fields = @weather_data_parser.parse(weather_data)
        @weather_data_cache.cache_weather_data(cache_key, weather_fields)
      end
    end

    event.set('[weather]', weather_fields) if weather_fields

    filter_matched(event)
  end

  def cache_key
    "#{@latitude}_#{@longitude}"
  end
end
