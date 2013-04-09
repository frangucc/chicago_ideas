FactoryGirl.define do
  factory :order do
    name_on_card      'John Doe'
    card_number       123456789
    expiry_date_month 15
    expiry_date_year  22
    cvc               123
    amount            75
    association       :member_type, :factory => :member_type
    association       :user,        :factory => :user
  end
end
