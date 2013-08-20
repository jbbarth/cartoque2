module API::UsersRepresenter
  include Roar::Representer::JSON::HAL
  include Roar::Representer::Feature::Hypermedia

  collection :users, class: User,
                       extend: API::UserRepresenter,
                       embedded: true

  # The "users" method is used above and serves as a key in the "_embedded"
  # hash of the representation. Here we alias it to the "collect" method which
  # will be called on the enumerable (a collection of User's in standard cases
  # for us)
  def users
    collect
  end

  link :self do
    api_users_path
  end

  link :create do
    { href: api_users_path, method: "POST" }
  end
end
