class AddCurrentBudgetToBhsiApplications < ActiveRecord::Migration

  def up
    add_attachment :bhsi_applications, :current_budget
  end

  def down
    remove_attachment :bhsi_applications, :current_budget
  end

end
