FactoryGirl.define do
  factory :<%= singular_name %> do |a|
<% attributes.reject(&:password_digest?).each do |attribute| -%>
    a.<%= attribute.name %> "something"
<% end -%>
  end
end
