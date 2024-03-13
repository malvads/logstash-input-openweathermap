# frozen_string_literal: true

#
# Class to manage rbwindow data
#
class WeatherStoreManager
  def initialize(store, memcached)
    @store = store
    @memcached = memcached
  end

  def lat_lon_from_uuid(uuid)
    data = @memcached.fetch_cached_data(@store)
    return [0, 0] unless data && data[uuid] && data[uuid]['sensor_latlong']

    data[uuid]['sensor_latlong'].split(',').map(&:to_f)
  end
end
