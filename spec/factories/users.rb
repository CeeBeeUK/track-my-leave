FactoryGirl.define do
  factory :user do
    name 'test user'
    provider 'google'
    uid '123456789'
  end
end
