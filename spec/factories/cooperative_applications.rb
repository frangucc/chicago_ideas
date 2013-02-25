# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cooperative_application do
    sequence(:id)      { |n| n }
    name               'John'
    last_name          'Doe'
    title              'Title'
    organization       'Organization'
    phone              '123-4567'
    org_mission        'Organization Mission'
    org_twitter        'johndoe'
    org_website        'www.organization.com'
    reason             'Reason'
    worked_on          'Worked On'
    part_meaningful    'Meaningful Part'
    ins_failure        'Failure instance'
    neighborhood       'Neighborhood'
    assisted_area      'Assisted Area'
    recommend          'Recommendations'
    email              'johndoe@domain.com'
    passion_1          'passion1'
    passion_2          'passion2'
    passion_3          'passion3'
  end
end
