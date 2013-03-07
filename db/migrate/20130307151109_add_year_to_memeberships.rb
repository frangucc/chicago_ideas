class AddYearToMemeberships < ActiveRecord::Migration

  YEAR_2012 = 2012
  YEAR_2013 = 2013

  def up
    # Add year association column to member types.
    change_table :member_types do |t|
      t.references :year
    end

    # Remove index by title.
    remove_index :member_types, :name => :index_member_types_on_name

    # Associate member types created in 2012 to year 2012.
    MemberType.select { |mt| mt.created_at.year == YEAR_2012 }.each do |member_type|
      member_type.update_attributes!(:year_id => YEAR_2012)
    end

    # Associate member types created in 2013 to year 2013.
    MemberType.select { |mt| mt.created_at.year == YEAR_2013 }.each do |member_type|
      member_type.update_attributes!(:year_id => YEAR_2013)
    end

    # Duplicate member types created in 2012 and associate the copies to year 2013
    MemberType.select { |mt| mt.created_at.year == YEAR_2012 }.each do |member_type|
      cloned_member_type = member_type.dup
      cloned_member_type.year_id = YEAR_2013
      cloned_member_type.save!
    end
  end

  def down
    # Remove duplicated member types.
    grouped_member_types = MemberType.all.group_by { |member_type| [member_type.title] }
    grouped_member_types.values.each do |duplicates|
      duplicates.shift
      duplicates.each { |double| double.destroy }
    end

    # Remove year association column from member types table.
    change_table :member_types do |t|
      t.remove :year_id
    end

    # Add index by title.
    add_index :member_types, [:title], :unique => true, :name => :index_member_types_on_name
  end

end
