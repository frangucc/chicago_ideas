class ChangesToBhsiApplications < ActiveRecord::Migration

  def up
    change_table :bhsi_applications do |t|
      t.change :distinguish_yourself, :text, :limit => 16777215, :default => "", :null => false
      t.remove :budget_previous_year
      t.remove :budget_current_year
    end
    add_attachment :bhsi_applications, :budget_previous_year
    add_attachment :bhsi_applications, :budget_current_year
  end

  def down
    change_table :bhsi_applications do |t|
      t.change :distinguish_yourself
      t.column :budget_previous_year, :text, :default => "", :null => false
      t.column :budget_current_year,  :text, :default => "", :null => false
    end
    t.remove_attachment :budget_previous_year
    t.remove_attachment :budget_current_year
  end

end
