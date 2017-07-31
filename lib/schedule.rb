require_relative 'config'

#
# Retrieving the schedule
#
# Usage:
#    bundle exec ruby schedule.rb <start_time> <end_time>
#
# Documentation:
# https://developer.pike13.com/docs/api/v2#endpoint-eventoccurrence
#

from, to = *ARGV

puts "Fetching the schedule from #{from} to #{to}..."

# Note: This uses the "front" API.  This will only return event occurrences that are publicly
# available.  This is analogous to visiting the website as a client.  If you wish to retrieve
# schedule information that is only accessible to staff, use the "desk" equivalent endpoint.
rsp = HTTParty.get(HOST + "/api/v2/front/event_occurrences?from=#{from}&to=#{to}&access_token=#{ACCESS_TOKEN}")
if rsp.success?
  if rsp['event_occurrences'].present?
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
    puts "Nothing scheduled"
  end
else
  puts "FAILED!"
  puts "Returned: #{rsp.code}"
  pp rsp
end

