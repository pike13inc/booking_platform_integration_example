require_relative 'config'

#
# Finds or creates a client by email address
#
# Usage:
#
#   bundle exec ruby person.rb <email> <first_name> <last_name>
#

# Finds a person by email or creates one.
def find_or_create_client(email, first_name, last_name)
  print "Looking up client by email: #{email}..."
  person_id = find_client_by_email(email)
  if person_id
    puts "FOUND: #{person_id}"
  else
    puts "not found"
    print "Creating client client for #{email}..."
    person = create_object("people", person: {email: email, first_name: first_name, last_name: last_name})
    puts "CREATED: #{person['id']} (put this in a safe place)"
  end
end

#
# Finds a person by email
#
# Documentation:
# https://developer.frontdeskhq.com/docs/api/v2#endpoint-person
#
def find_client_by_email(email)
  rsp = HTTParty.get(HOST + "/api/v2/desk/people/search?q=#{email}&fields=email&access_token=#{ACCESS_TOKEN}")
  raise "Request failed: #{rsp.code}, #{rsp}" unless rsp.success?

  if rsp['results'].length > 0
    rsp['results'][0]['person']['id']
  end
end


email, first_name, last_name = *ARGV
find_or_create_client(email, first_name, last_name)




