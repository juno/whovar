FactoryGirl.define do
  factory :item do
    user
    title 'Test Item'
    url 'http://example.com/test'
  end
end
