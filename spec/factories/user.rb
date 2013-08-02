FactoryGirl.define do
  factory :user do |u|
    u.email 'john@example.net'
    u.password 'foobar123'
  end
end
