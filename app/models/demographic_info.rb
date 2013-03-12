class DemographicInfo < ActiveRecord::Base

  belongs_to :user

  RACE = [ "Black or African American",
           "Asian",
           "Latino or Hispanic",
           "White",
           "American Indian or Alaska Native",
           "Native Hawaiian or Other Pacific Islander",
           "Other"
         ]

  INDUSTRY = [  "Arts",
                "Education",
                "Travel",
                "Electronic",
                "Broadcasting and Entertainment",
                "Services",
                "Insurance",
                "Construction",
                "Buildings & Real Estate",
                "Entrepreneurship",
                "Mining",
                "Retail Trade",
                "Public Administration",
                "Human Resources",
                "Technology",
                "Marketing & Communications",
                "Beverage, Food, Tobacco",
                "Finance",
                "Venture Capital",
                "Ecological",
                "Utilities",
                "Banking",
                "Telecommunications",
                "Leisure, Amusement, & Entertainment",
                "Agriculture",
                "Wholesale Trade",
                "Manufacturing",
                "Transportation",
                "Other"
              ]

  INCOME = [  "Under $10,000",
              "$10,000 - $35,000",
              "$35,000 - $50,000",
              "$50,000 - $75,000",
              "$75,000 - $125,000",
              "Over $125,000"
           ]

  GENDER = %w(Male Female)

  AGE = [ "17 or younger",
          "18-20",
          "21-29",
          "30-39",
          "40-49",
          "50-59",
          "60 or older"
        ]

  def self.options_hash(attr)
    const = attr.upcase.to_sym
    if self.constants.include?(const)
      hash = {}
      self.const_get(const).each_with_index { |value, index| hash[value] = index }
      hash
    end
  end

  %w(race industry income gender age).each do |meth|
    define_method "#{meth}_value" do
      not_once = self.send(meth.to_sym)
      not_once.present? ? DemographicInfo.const_get(meth.upcase)[not_once.to_i] : "-"
    end
  end
end
