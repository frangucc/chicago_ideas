FactoryGirl.define do
  factory :address do
    sequence(:id) { |n| n }
    street_1      '1st Street'
    street_2      '2nd Street'
    city          'Dallas'
    zip           '11400'
    country       'USA'
    state         'Texas'
    phone         '123-456-789'
  end
end