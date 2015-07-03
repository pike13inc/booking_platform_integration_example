require_relative 'config'

#
# Late canceling a visit
#
# Usage:
#    bundle exec ruby late_cancel <visit_id>
#

visit_id = ARGV[0]
puts "Marking visit as late cancel..."
update_object('visits', visit_id, visit: {state_event: 'late_cancel'})
