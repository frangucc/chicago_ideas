class AddFieldsToBhsiApplications < ActiveRecord::Migration

  def change
    change_table :bhsi_applications do |t|
      t.boolean :org_founder
      t.text    :org_join_point
      t.text    :total_budget_current_year, :null => false
      t.text    :major_sources_income,      :null => false
      t.text    :impact,                    :null => false
      t.text    :obstacles_needs,           :null => false
      t.text    :budget_previous_year,      :null => false
      t.text    :budget_current_year,       :null => false
    end
  end

end
