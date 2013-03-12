FactoryGirl.define do
  factory :user do
    sequence(:id) { |n| n }
    name          'John Doe'
    email         'john@doe.com'
    password      'password'
    admin         false
    is_speaker    false
    staff         false
    is_volunteer  false
    association   :address,     :factory => :address
  end
end
