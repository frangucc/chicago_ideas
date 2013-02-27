FactoryGirl.define do
  factory :member_type do
    sequence(:id)       { |n| n }
    title               'Ignition Member'
    specific_benefits   "10% discount on all ticket sales\r\nInsider Updates\r\nMember recognition on badge"
    general_benefits    '1 Ticket to the Edison Talks'
    min_price_in_cents  75
    #max_price_in_cents  100
    #projected_members
    #maximum_members
    #value
  end
end
