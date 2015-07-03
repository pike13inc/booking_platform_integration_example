def retrieve_object(type, id)
  rsp = HTTParty.get(HOST + "/api/v2/desk/#{type}/#{id}?access_token=#{ACCESS_TOKEN}")
  raise "Request failed: #{rsp.code}, #{rsp}" unless rsp.success?
  rsp[type][0]
end

def create_object(type, body, path = nil)
  path ||= "/api/v2/desk/#{type}?access_token=#{ACCESS_TOKEN}"
  rsp = HTTParty.post(HOST + path, body: body)
  raise "Request failed: #{rsp.code}, #{rsp}" unless rsp.success?
  rsp[type][0]
end

def update_object(type, id, body)
  rsp = HTTParty.put(HOST + "/api/v2/desk/#{type}/#{id}?access_token=#{ACCESS_TOKEN}", body: body)
  raise "Request failed: #{rsp.code}, #{rsp}" unless rsp.success?
  rsp[type][0]
end

def delete_object(type, id)
  path ||= "/api/v2/desk/#{type}?access_token=#{ACCESS_TOKEN}"
  rsp = HTTParty.delete(HOST + path)
  raise "Request failed: #{rsp.code}, #{rsp}" unless rsp.success?
end
