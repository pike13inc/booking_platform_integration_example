require_relative 'config'

#
# Setup: Creating the PackProduct
#
# Documentation:
# https://developer.frontdeskhq.com/docs/api/v2?preview=true#endpoint-pack-product
#
body = {
  pack_product: {
    product: {
      name: "ClassPass Visit",
      price_cents: 500,
      # Only visible to staff (prevents this from showing up in the client-facing shop)
      visibility: 'staff',
      description: 'Pass used to pay for ClassPass visits'
    },
    count: 1,
    send_expiration_notifications: false,
    commitment_length: 12,
    commitment_unit: 'month',

    # Since the integration will be manually issuing the punch (which uses a Pack to
    # pay for a Visit), there is not need to specify which services this Pack will cover.
    service_ids: []
  }
}
rsp = HTTParty.post(HOST + "/api/v2/desk/pack_products?access_token=#{ACCESS_TOKEN}", body: body)
if rsp.success?
  pack_product_id = rsp['pack_products'][0]['id']
  puts "SUCCESS: Created PackProduct: #{pack_product_id}!  Put this in a safe spot."
else
  puts "FAILED!"
  puts "Returned: #{rsp.code}"
  pp rsp
end
