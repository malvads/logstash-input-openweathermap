# frozen_string_literal: true

# logstash-filter-openweathermap.rb

require 'logstash/filters/base'
require 'logstash/namespace'

require_relative 'utils/data_cache'
require_relative 'utils/data_fetcher'
require_relative 'utils/data_parser'
require_relative 'utils/event_manager'
require_relative 'utils/memcached_config'
require_relative 'utils/store'
require_relative 'models/weather'

module LogStash
  module Filters
    #
    # Base filter to enrich events with OpenWeatherMap data
    #
    class OpenWeatherMap < LogStash::Filters::Base
      config_name 'openweathermap'

      config :rbwindow_data_store, validate: :string, required: true
      config :cache_expiration_seconds, validate: :number, required: true
      config :api_key, validate: :string, required: true

      def register
        @memcached_servers = MemcachedConfig.servers
        @weather_data_fetcher = WeatherDataFetcher.new @api_key
        @memcached_manager = MemcachedManager.new(@memcached_servers, @cache_expiration_seconds)
        @store = WeatherStoreManager.new(@rbwindow_data_store, @memcached_manager)
        @cache = CacheGenerator.new
        @weather_data_parser = WeatherDataParser.new
      end

      def filter(event)
        lat, lon = @store.lat_lon_from_uuid(EventManager.uuid_from_event(event))
        return if [lat, lon] == [0, 0]

        cached_weather_data = @memcached_manager.fetch_cached_data(@cache.gen_memcached_key(lat, lon))

        if cached_weather_data.nil?
          weather_data = @weather_data_fetcher.fetch_weather_data(lat, lon)
          cached_weather_data = @weather_data_parser.parse(weather_data) if weather_data
          @memcached_manager.cache_data(@cache.gen_memcached_key(lat, lon), cached_weather_data) if cached_weather_data
        end

        cached_weather_data&.each { |key, value| event.set("[#{key}]", value) }

        filter_matched(event)
      end
    end
  end
end
