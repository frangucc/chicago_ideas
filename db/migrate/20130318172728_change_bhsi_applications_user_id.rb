class ChangeBhsiApplicationsUserId < ActiveRecord::Migration
  def up
    change_column :bhsi_applications, :user_id, :integer, null: true
  end

  def down
    change_column :bhsi_applications, :user_id, :integer, null: false
  end
end
