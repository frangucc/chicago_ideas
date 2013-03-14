class AddCompanyNameToMembers < ActiveRecord::Migration

  def change
    add_column :members, :company_name, :string
  end

end
