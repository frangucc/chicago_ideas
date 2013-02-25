FactoryGirl.define do
  factory :order do
    name_on_card 'John Doe'
    email        'john@doe.com'
    address      '1st Street'
    city         'Dallas'
    state        'Texas'
    card_number  123456789
    zip          11400
    expiry_date  2215
    cvc          123
  end
end
