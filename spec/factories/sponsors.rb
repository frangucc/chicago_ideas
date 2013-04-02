FactoryGirl.define do
  factory :sponsor do
    name        "TIME Magazine"
    description ""
    url         "http://www.time.com/time/"
    association :sponsorship_level, :factory => :sponsorship_level
  end
end
