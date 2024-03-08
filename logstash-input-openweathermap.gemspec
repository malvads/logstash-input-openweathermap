Gem::Specification.new do |s|
  s.name = 'logstash-input-openweathermap'
  s.version = '0.0.1'
  s.licenses = ['Afferp General 3.0']
  s.summary = "Logstash input plugin to fetch data from openweathermap"
  s.description = "This plugin allows Logstash to fetch data from OpenWeatherMap."
  s.authors = ["Malvads"]
  s.homepage = "https://github.com/malvads/logstash-input-openweathermap"
  s.require_paths = ["lib"]

  # Files
  s.files = Dir.glob("lib/**/*")

  # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a Logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "input" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core-plugin-api", ">= 1.60", "<= 2.99"
  s.add_runtime_dependency 'logstash-codec-plain'
  s.add_runtime_dependency 'open-weather-ruby-client'
  s.add_development_dependency 'logstash-devutils'
end
