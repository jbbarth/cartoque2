module API::OperatingSystemRepresenter
  include Roar::Representer::JSON::HAL
  include Roar::Representer::Feature::Hypermedia

  property :id
  property :name
  property :codename
  property :supported_until
  property :created_at, writeable: false
  property :updated_at, writeable: false

  link :self do
    api_operating_system_path(self)
  end
end
