class BhsiApplicationsIsOrgFounder < ActiveRecord::Migration
  def change
    change_column :bhsi_applications, :org_founder, :boolean, default: nil, null: true
  end
end
