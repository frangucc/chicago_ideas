FactoryGirl.define do
  factory :user do
    name             'John Doe'
    sequence(:email) { |n| "john_#{n}@doe.com" }
    password         'password'
    admin            false
    is_speaker       false
    staff            false
    is_volunteer     false
    association      :address, :factory => :address
  end
end
