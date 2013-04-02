FactoryGirl.define do
  factory :sponsor_user do
    association :user,    :factory => :user
    association :sponsor, :factory => :sponsor
  end
end
