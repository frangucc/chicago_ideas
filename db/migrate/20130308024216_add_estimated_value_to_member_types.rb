class AddEstimatedValueToMemberTypes < ActiveRecord::Migration

  def change
    add_column :member_types, :estimated_value, :string
  end

end
