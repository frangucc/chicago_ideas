class BhsiApplicationsIsOrgFounder < ActiveRecord::Migration
  def change
    remove_column :bhsi_applications, :org_founder
    add_column :bhsi_applications, :org_founder, :boolean
  end
end
