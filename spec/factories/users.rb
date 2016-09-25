FactoryGirl.define do
  factory :user do
    name 'test user'
    provider 'google'
    uid '123456789'
    start_month 1
    start_day 1
  end
end
