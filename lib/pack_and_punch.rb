require_relative 'config'

#
# Pays for a visit by creating a pack and a punch
#
# Usage:
#   bundle exec ruby pack_and_punch.rb <person_id> <visit_id> <pack_product_id>
#

person_id, visit_id, pack_product_id  = ARGV

pack = create_object('packs', {pack: {person_ids: [person_id]}}, "/api/v2/desk/pack_products/#{pack_product_id}/packs?access_token=#{ACCESS_TOKEN}")
puts "Created pack #{pack['id']}"

punch = create_object('punches', punch: {visit_id: visit_id, plan_id: pack['id']})
puts "Created punch #{punch['id']}"

