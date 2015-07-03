require_relative 'config'

#
# Cancels a visit and optionally deletes the plan that paid for it
#
# Usage:
#   bundle exec ruby cancel.rb <visit_id> [delete_plan true|false]
#

def retrieve_punch_for_visit_id(visit_id)
  visit = retrieve_object('visits', visit_id)
  retrieve_object('punches', visit['punch_id'])
end

visit_id, delete_plan = *ARGV
delete_plan = delete_plan == 'true'
if delete_plan
  # In order to delete the plan, we need to retrieve the
  # punch in order to get the plan id.
  punch = retrieve_punch_for_visit_id(visit_id)
  if punch['plan_id'].present?
    puts "Deleting plan: #{punch['plan_id']}"
    delete_object('packs', punch['plan_id'])
  end
end
puts "Deleting visit: #{visit_id}"
delete_object('visits', visit_id)

