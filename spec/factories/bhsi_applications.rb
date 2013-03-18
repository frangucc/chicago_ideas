FactoryGirl.define do
  factory :bhsi_application do
    first_name                           'Mark'
    last_name                            'Kabban'
    address1                             '3637 Saddle Dr'
    city                                 'Spring Valley'
    state                                'CA'
    country                              'US'
    phone_number                         '619-9208650'
    zipcode                              '91977'
    sequence(:email)                     { |n| "derp_#{n}@example.com" }
    gender                               'Male'
    birthdate                            '04/18/1987'
    title                                'Executive Director'
    social_venture_name                  'Youth And Leaders Living Actively-YALLA'
    legal_structure                      '501c3'
    url                                  'http://www.yallasd.com'
    twitter_handle                       'Yallasd'
    video_url                            'http://www.youtube.com/user/yallasandiego'
    applied_before                       'Yes'
    makes_social_innovation              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin at odio eu sapien placerat placerat id vel ipsum. Donec bibendum tellus sit amet augue luctus viverra. Ut at vulputate sapien. Integer pharetra, sapien nec pellentesque egestas, dui mi ornare justo, quis rutrum dui lorem vel nunc. Pellentesque a vulputate eros. Aliquam quis odio ac orci vehicula rhoncus. Aenean varius nisl eleifend ligula pulvinar sagittis. Nunc mollis, diam quis mollis hendrerit, dolor quam semper lorem, nec fringilla metus sem et lacus. Mauris ultrices urna et mi molestie sit amet adipiscing libero bibendum. Pellentesque adipiscing mauris non nisl blandit congue. Nulla nec."
    inspiration                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin at odio eu sapien placerat placerat id vel ipsum. Donec bibendum tellus sit amet augue luctus viverra. Ut at vulputate sapien. Integer pharetra, sapien nec pellentesque egestas, dui mi ornare justo, quis rutrum dui lorem vel nunc. Pellentesque a vulputate eros. Aliquam quis odio ac orci vehicula rhoncus. Aenean varius nisl eleifend ligula pulvinar sagittis. Nunc mollis, diam quis mollis hendrerit, dolor quam semper lorem, nec fringilla metus sem et lacus. Mauris ultrices urna et mi molestie sit amet adipiscing libero bibendum. Pellentesque adipiscing mauris non nisl blandit congue. Nulla nec."
    sustainability_model                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin at odio eu sapien placerat placerat id vel ipsum. Donec bibendum tellus sit amet augue luctus viverra. Ut at vulputate sapien. Integer pharetra, sapien nec pellentesque egestas, dui mi ornare justo, quis rutrum dui lorem vel nunc. Pellentesque a vulputate eros. Aliquam quis odio ac orci vehicula rhoncus. Aenean varius nisl eleifend ligula pulvinar sagittis. Nunc mollis, diam quis mollis hendrerit, dolor quam semper lorem, nec fringilla metus sem et lacus. Mauris ultrices urna et mi molestie sit amet adipiscing libero bibendum. Pellentesque adipiscing mauris non nisl blandit congue. Nulla nec."
    improvements                         "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin at odio eu sapien placerat placerat id vel ipsum. Donec bibendum tellus sit amet augue luctus viverra. Ut at vulputate sapien. Integer pharetra, sapien nec pellentesque egestas, dui mi ornare justo, quis rutrum dui lorem vel nunc. Pellentesque a vulputate eros. Aliquam quis odio ac orci vehicula rhoncus. Aenean varius nisl eleifend ligula pulvinar sagittis. Nunc mollis, diam quis mollis hendrerit, dolor quam semper lorem, nec fringilla metus sem et lacus. Mauris ultrices urna et mi molestie sit amet adipiscing libero bibendum. Pellentesque adipiscing mauris non nisl blandit congue. Nulla nec."
    distinguish_yourself                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin at odio eu sapien placerat placerat id vel ipsum. Donec bibendum tellus sit amet augue luctus viverra. Ut at vulputate sapien. Integer pharetra, sapien nec pellentesque egestas, dui mi ornare justo, quis rutrum dui lorem vel nunc. Pellentesque a vulputate eros. Aliquam quis odio ac orci vehicula rhoncus. Aenean varius nisl eleifend ligula pulvinar sagittis. Nunc mollis, diam quis mollis hendrerit, dolor quam semper lorem, nec fringilla metus sem et lacus. Mauris ultrices urna et mi molestie sit amet adipiscing libero bibendum. Pellentesque adipiscing mauris non nisl blandit congue. Nulla nec."
    major_sources_income                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin at odio eu sapien placerat placerat id vel ipsum. Donec bibendum tellus sit amet augue luctus viverra. Ut at vulputate sapien. Integer pharetra, sapien nec pellentesque egestas, dui mi ornare justo, quis rutrum dui lorem vel nunc. Pellentesque a vulputate eros. Aliquam quis odio ac orci vehicula rhoncus. Aenean varius nisl eleifend ligula pulvinar sagittis. Nunc mollis, diam quis mollis hendrerit, dolor quam semper lorem, nec fringilla metus sem et lacus. Mauris ultrices urna et mi molestie sit amet adipiscing libero bibendum. Pellentesque adipiscing mauris non nisl blandit congue. Nulla nec."
    impact                               "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    obstacles_needs                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    reference_1_name                     "Ted Mansour"
    reference_1_relationship             "President of Police Officers Association- Supporters of YALLA"
    reference_1_phone                    "619 817 6050"
    reference_1_email                    "anotherunknown@user.com"
    reference_2_name                     "Sylvia Casas-Werkman"
    reference_2_relationship             "Principal of local elementary"
    reference_2_phone                    "6195883075"
    reference_2_email                    "anotherunknown2@user.com"
    agreement_accepeted                  true
    org_founder                          true
    total_budget_current_year            1500000
    budget_previous_year                 20000
    budget_current_year                  3000
    association                          :bhsi_longtext, factory: :bhsi_longtext
  end
end
