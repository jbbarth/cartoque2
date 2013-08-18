module API::ContactsRepresenter
  include Roar::Representer::JSON::HAL
  include Roar::Representer::Feature::Hypermedia

  collection :contacts, class: Contact,
                       extend: API::ContactRepresenter,
                       embedded: true

  # The "contacts" method is used above and serves as a key in the "_embedded"
  # hash of the representation. Here we alias it to the "collect" method which
  # will be called on the enumerable (a collection of Contact's in standard cases
  # for us)
  def contacts
    collect
  end

  link :self do
    api_contacts_path
  end
end
