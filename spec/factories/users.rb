FactoryGirl.define do
  factory :user do
    provider 'github'
    uid '1'
    username 'foo'
    name 'Foo Bar'
    avatar_url 'http://example.com/image.jpg'
  end
end

