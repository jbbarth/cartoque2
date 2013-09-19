module API::<%= class_name %>Representer
  include Roar::Representer::JSON::HAL
  include Roar::Representer::Feature::Hypermedia

  property :id
<% attributes.reject(&:password_digest?).each do |attribute| -%>
  property :<%= attribute.name %>
<% end -%>
  property :created_at, writeable: false
  property :updated_at, writeable: false

  link :self do
    api_<%= singular_name %>_path(self)
  end
end
