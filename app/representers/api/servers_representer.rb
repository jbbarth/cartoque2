module API::ServersRepresenter
  include Roar::Representer::JSON::HAL
  include Roar::Representer::Feature::Hypermedia

  collection :servers, class: Server,
                       extend: API::ServerRepresenter,
                       embedded: true

  # The "servers" method is used above and serves as a key in the "_embedded"
  # hash of the representation. Here we alias it to the "collect" method which
  # will be called on the enumerable (a collection of Server's in standard cases
  # for us)
  def servers
    collect
  end

  link :self do
    servers_path(self)
  end
end
