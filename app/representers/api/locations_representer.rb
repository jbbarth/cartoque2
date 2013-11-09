module API::LocationsRepresenter
  include Roar::Representer::JSON::HAL
  include Roar::Representer::Feature::Hypermedia
  include PaginationRepresenter

  collection :locations, class: Location,
                       extend: API::LocationRepresenter,
                       embedded: true

  # The "locations" method is used above and serves as a key in the "_embedded"
  # hash of the representation. Here we alias it to the "collect" method which
  # will be called on the enumerable (a collection of Location's in standard cases
  # for us)
  def locations
    collect
  end

  # Generates url in PaginationRepresenter
  def page_url(*args)
    api_locations_path(*args)
  end

  link :create do
    { href: api_locations_path, method: "POST" }
  end
end
