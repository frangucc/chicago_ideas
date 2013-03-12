FactoryGirl.define do
  factory :order do
    sequence(:id) { |n| n }
    name_on_card  'John Doe'
    card_number   123456789
    expiry_date   2215
    cvc           123
    amount        75
    association   :member_type, :factory => :member_type
    association   :user,        :factory => :user
  end
end
