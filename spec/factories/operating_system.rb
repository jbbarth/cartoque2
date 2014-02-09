FactoryGirl.define do
  factory :operating_system do |a|
    a.name "something"
    a.codename "something"
    #a.supported_until Date.new("01/01/2020")
  end
end
