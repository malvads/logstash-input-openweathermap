# frozen_string_literal: true

#
# Class to manage the event, for example extracting uuid based
# on the event type
#
class EventManager
  def self.uuid_from_event(event)
    case event.get('[type]')
    when 'campus'
      event.get('[campus_uuid]')
    when 'building'
      event.get('[building_uuid]')
    when 'floor', 'zone'
      event.get('[building_uuid]')
    else
      raise ArgumentError, "Invalid event type: #{event['type']}"
    end
  end
end
