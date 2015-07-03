require_relative 'config'

#
# Registering a person for a class and pays pays for it using a pack
#
# Usage:
#   bundle exec ruby visit.rb <person_id> <event_occurrence_id> <pack_product_id>
#


#
# Registers a client for an event occurrence
#
# Documentation:
# https://developer.frontdeskhq.com/docs/api/v2#endpoint-visit
#
def create_visit(person_id, event_occurrence_id)
  body = {
    visit: {
      person_id: person_id,
      event_occurrence_id: event_occurrence_id
    }
  }
  rsp = HTTParty.post(HOST + "/api/v2/desk/visits?access_token=#{ACCESS_TOKEN}", body: body)
  raise "Request failed: #{rsp.code}, #{rsp}" unless rsp.success?
  rsp['visits'][0]['id']
end

#
# Creates a pack which can be used to pay for a visit
#
# Documentation:
# https://developer.frontdeskhq.com/docs/api/v2#endpoint-pack
#
def create_pack(person_id, pack_product_id)
  body = {
    pack: {
      person_ids: [person_id]
    }
  }
  rsp = HTTParty.post(HOST + "/api/v2/desk/pack_products/#{pack_product_id}/packs?access_token=#{ACCESS_TOKEN}", body: body)
  raise "Request failed: #{rsp.code}, #{rsp}" unless rsp.success?
  rsp['packs'][0]['id']
end

#
# Creates a punch to use a pack to pay for a visit
#
# Documentation:
# https://developer.frontdeskhq.com/docs/api/v2#endpoint-punch
#
def create_punch(visit_id, pack_id)
  body = {
    punch: {
      visit_id: visit_id,
      plan_id: pack_id
    }
  }
  rsp = HTTParty.post(HOST + "/api/v2/desk/punches?access_token=#{ACCESS_TOKEN}", body: body)
  raise "Request failed: #{rsp.code}, #{rsp}" unless rsp.success?
  rsp['punches'][0]['id']
end

person_id, event_occurrence_id, pack_product_id  = ARGV

visit_id = create_visit(person_id, event_occurrence_id)
puts "Created visit #{visit_id}"

pack_id = create_pack(person_id, pack_product_id)
puts "Created pack #{pack_id}"

punch_id = create_punch(visit_id, pack_id)
puts "Created punch #{punch_id}"

