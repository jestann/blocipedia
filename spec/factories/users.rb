FactoryGirl.define do
  factory :user do
    name RandomData.random_name
    role :standard
    sequence(:email) {|n| "user#{n}@factory.com" }
    password "testing"
    password_confirmation "testing"
    confirmed_at Date.today
  end
end
