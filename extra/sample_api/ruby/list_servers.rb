#!/usr/bin/env ruby

# hyperclient is a gem which ease the development of clients for
# REST, HAL-compliants API (which is the case of Cartoque)
require "hyperclient"

# here we define a new Hyperclient client, retrieving the URL and token from
# environment variables
root_endpoint = Hyperclient.new("#{ENV["CARTOQUE_URL"]}/api").tap do |api|
  api.headers.merge! "X-Api-Token" => "#{ENV["CARTOQUE_TOKEN"]}"
end

# finally we can use that to reach servers and print their name
root_endpoint.links.servers.embedded.servers.each do |server|
  puts server.attributes["name"]
end
