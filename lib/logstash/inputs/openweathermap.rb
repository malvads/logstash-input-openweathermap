# logstash-input-openweathermap

require "logstash/inputs/base"
require "logstash/namespace"
require "net/http"
require "json"
require "stud/interval"

class LogStash::Inputs::OpenWeatherMap < LogStash::Inputs::Base
  config_name "openweathermap"

  # Define the configuration options
  config :api_key, :validate => :string, :required => true
  config :latitude, :validate => :number, :required => true
  config :longitude, :validate => :number, :required => true

  public
  def register
    @url = "https://api.openweathermap.org/data/2.5/weather?lat=#{@latitude}&lon=#{@longitude}&appid=#{@api_key}"
    @logger.info "OpenWeatherMap input registered"
  end

  private

  def current_weather
    uri = URI.parse(@url)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
  end

  def run(queue)
    Stud.interval(60) do
      begin
        weather = current_weather
        event = LogStash::Event.new(
          "name" => weather["name"],
          "humidity" => weather["main"]["humidity"],
          "temp" => weather["main"]["temp"],
          "weather_icon" => weather["weather"][0]["icon"],
          "weather_description" => weather["weather"][0]["description"],
          "wind_speed" => weather["wind"]["speed"] # meters per second
        )
        decorate(event)
        queue << event
      rescue => e
        @logger.error("Error processing event", :exception => e, :backtrace => e.backtrace)
      end
    end
  end
end
