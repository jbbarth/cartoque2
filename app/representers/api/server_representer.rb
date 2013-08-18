module API::ServerRepresenter
  include Roar::Representer::JSON::HAL
  include Roar::Representer::Feature::Hypermedia

  property :id
  property :name
  property :created_at, writeable: false
  property :updated_at, writeable: false

  link :self do
    api_server_path(self)
  end
end
