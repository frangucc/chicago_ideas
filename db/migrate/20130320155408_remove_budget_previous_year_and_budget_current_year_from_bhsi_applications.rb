class RemoveBudgetPreviousYearAndBudgetCurrentYearFromBhsiApplications < ActiveRecord::Migration

  def up
    change_table :bhsi_applications do |t|
      t.remove :budget_previous_year
      t.remove :budget_current_year
    end
  end

  def down
    change_table :bhsi_applications do |t|
      t.column :budget_previous_year, :text
      t.column :budget_current_year,  :text
    end
  end

end
