class ChangeOrgFounder < ActiveRecord::Migration

  def up
    change_table :bhsi_applications do |t|
      t.change :org_founder, :string, :default => "", :null => false
    end
  end

end
