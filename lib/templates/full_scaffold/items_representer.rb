module API::<%= class_name.pluralize %>Representer
  include Roar::Representer::JSON::HAL
  include Roar::Representer::Feature::Hypermedia

  collection :<%= plural_name %>, class: <%= class_name %>,
                       extend: API::<%= class_name %>Representer,
                       embedded: true

  # The "<%= plural_name %>" method is used above and serves as a key in the "_embedded"
  # hash of the representation. Here we alias it to the "collect" method which
  # will be called on the enumerable (a collection of <%= class_name %>'s in standard cases
  # for us)
  def <%= plural_name %>
    collect
  end

  link :self do
    api_<%= plural_name %>_path
  end

  link :create do
    { href: api_<%= plural_name %>_path, method: "POST" }
  end
end
