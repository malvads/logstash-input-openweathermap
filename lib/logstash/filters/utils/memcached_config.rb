require "yaml"

module MemcachedConfig

  MEMCACHED_CONFIG_FILE="/opt/rb/var/www/rb-rails/config/memcached_config.yml" unless defined? MEMCACHED_CONFIG_FILE

  def self.servers
   servers = []
   if File.exist?(MEMCACHED_CONFIG_FILE)
         production_config = YAML.load_file(MEMCACHED_CONFIG_FILE)
         servers = production_config["production"]["servers"]
   end
   servers.push("localhost:11211") if servers.empty?
   return servers
  end

end
