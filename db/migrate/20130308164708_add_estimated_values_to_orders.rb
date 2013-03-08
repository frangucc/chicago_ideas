class AddEstimatedValuesToOrders < ActiveRecord::Migration

  YEAR_2012 = 2012
  YEAR_2013 = 2013
  ESTIMATED_VALUES = { 'Spark' => '$33.00', 'Connector' => '$93.00', 'Collaborator' => '$233.00', 'Producer' => '$748.00', 'Menlo' => '$1,818.00', 'Edison' => '$3,958.00', 'Innovation' => '$1,593.00' }

  def change
    year_2012 = Year.find_by_id(YEAR_2012)
    year_2013 = Year.find_by_id(YEAR_2013)

    member_types_2012 = year_2012.member_types
    member_types_2013 = year_2013.member_types

    [member_types_2012, member_types_2013].each do |member_types|
      ESTIMATED_VALUES.each_pair do |member_title, estimated_value|
        if member_type = member_types.find_by_title(member_title)
          member_type.update_attributes(:estimated_value => estimated_value)
        end
      end
    end
  end

end
