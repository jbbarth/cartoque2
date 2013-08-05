FactoryGirl.define do
  factory :user do |u|
    u.email 'john@example.net'
    u.password 'foobar123'
    u.authentication_token '0c83677b014f4afb38e416539758c50b'
  end
end
