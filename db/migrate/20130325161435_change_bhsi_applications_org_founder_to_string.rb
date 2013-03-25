class ChangeBhsiApplicationsOrgFounderToString < ActiveRecord::Migration
  def change
    rename_column :bhsi_applications, :org_founder, :is_org_founder
    add_column :bhsi_applications, :org_founder, :string, :limit => 10

    BhsiApplication.all.each do |ba|
      ba.update_attribute(:org_founder, "#{ ba.is_org_founder? ? 'yes' : 'no' }")
    end

    remove_column :bhsi_applications, :is_org_founder
  end
end
