require_relative 'config'

#
# Retrieving the schedule
#
# Documentation:
# https://developer.frontdeskhq.com/docs/api/v2#endpoint-eventoccurrence
#
# Note: This uses the "front" API.  This will only return event occurrences that are publically
# available.  This is analogous to visiting the website as a client.  If you wish to retrieve
# schedule information that is only accessible to staff, use the "desk" equivelent endpoint.
rsp = HTTParty.get(HOST + "/api/v2/front/event_occurrences?from=2015-07-06T00:00:00-0700&to=2015-07-06T23:59:59-0700&access_token=#{ACCESS_TOKEN}")
if rsp.success?
  rsp['event_occurrences'].each do |event_occurrence|
    name = event_occurrence['name']

    # You will likely want to convert these to the appropriate timezone as they will be returned in UTC.
    # The timezone for the location of the event_occurrence is returned as well.
    timezone = event_occurrence['timezone']
    start_at = Time.parse(event_occurrence['start_at']).in_time_zone(timezone)
    end_at = Time.parse(event_occurrence['end_at']).in_time_zone(timezone)
    staff = event_occurrence['staff_members'].map { |s| s['name'] }.join(', ')
    puts "#{name}: #{start_at} to #{end_at} with #{staff}"
  end
else
  puts "FAILED!"
  puts "Returned: #{rsp.code}"
  pp rsp
end

