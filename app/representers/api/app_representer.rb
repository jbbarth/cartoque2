module API::AppRepresenter
  include Roar::Representer::JSON::HAL
  include Roar::Representer::Feature::Hypermedia

  property :id
  property :name
  property :created_at, writeable: false
  property :updated_at, writeable: false

  link :self do
    app_path(self)
  end
end