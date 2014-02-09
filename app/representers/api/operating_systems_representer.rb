module API::OperatingSystemsRepresenter
  include Roar::Representer::JSON::HAL
  include Roar::Representer::Feature::Hypermedia
  include PaginationRepresenter

  collection :operating_systems, class: OperatingSystem,
                       extend: API::OperatingSystemRepresenter,
                       embedded: true

  # The "operating_systems" method is used above and serves as a key in the "_embedded"
  # hash of the representation. Here we alias it to the "collect" method which
  # will be called on the enumerable (a collection of OperatingSystem's in standard cases
  # for us)
  def operating_systems
    collect
  end

  # Generates url in PaginationRepresenter
  def page_url(*args)
    api_operating_systems_path(*args)
  end

  link :create do
    { href: api_operating_systems_path, method: "POST" }
  end
end
