require_relative 'config'

#
# Registers a person for a class and pays for it using a pack
#
# Usage:
#   bundle exec ruby visit.rb <person_id> <event_occurrence_id>
#

person_id, event_occurrence_id = *ARGV

visit = create_object('visits', visit: {person_id: person_id, event_occurrence_id: event_occurrence_id})
puts "Created visit #{visit['id']}"

