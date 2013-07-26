json.array!(@servers) do |server|
  json.extract! server, :name
  json.url server_url(server, format: :json)
end
