module API::AppsRepresenter
  include Roar::Representer::JSON::HAL
  include Roar::Representer::Feature::Hypermedia
  include PaginationRepresenter

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

  # Generates url in PaginationRepresenter
  def page_url(*args)
    api_apps_path(*args)
  end

  link :create do
    { href: api_apps_path, method: "POST" }
  end
end
