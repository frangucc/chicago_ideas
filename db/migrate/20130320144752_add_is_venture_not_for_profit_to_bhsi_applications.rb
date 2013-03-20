class AddIsVentureNotForProfitToBhsiApplications < ActiveRecord::Migration

  def change
    add_column :bhsi_applications, :is_venture_not_for_profit, :boolean
  end

end
