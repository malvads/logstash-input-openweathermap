# frozen_string_literal: true

#
# Class to manage the generation of the memcached keys
#
class CacheGenerator
  def gen_memcached_key(lat, lon)
    "#{lat}_#{lon}"
  end
end

#
# Class to manage memcached get/set
#
class MemcachedManager
  def initialize(memcached_servers, cache_expiration_seconds)
    @memcached = Dalli::Client.new(memcached_servers)
    @cache_expiration_seconds = cache_expiration_seconds
  end

  def cache_data(key, data)
    @memcached.set(key, data, @cache_expiration_seconds)
  end

  def fetch_cached_data(key)
    @memcached.get(key)
  end
end
