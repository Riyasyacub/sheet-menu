FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "foo#{n}@bar.com" }
    password { 'password' }
  end
end
