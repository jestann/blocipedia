FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@factory.com" }
    password "testing"
    password_confirmation "testing"
    confirmed_at Date.today
  end
end
