module API::AppsRepresenter
  include Roar::Representer::JSON::HAL
  include Roar::Representer::Feature::Hypermedia

  collection :apps, class: App,
                       extend: API::AppRepresenter,
                       embedded: true

  # The "apps" method is used above and serves as a key in the "_embedded"
  # hash of the representation. Here we alias it to the "collect" method which
  # will be called on the enumerable (a collection of App's in standard cases
  # for us)
  def apps
    collect
  end

  link :self do
    apps_path(self)
  end
end
