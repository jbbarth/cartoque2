module API::UserRepresenter
  include Roar::Representer::JSON::HAL
  include Roar::Representer::Feature::Hypermedia

  property :id
  property :email
  property :seen_on
  property :created_at, writeable: false
  property :updated_at, writeable: false

  link :self do
    api_user_path(self)
  end
end
