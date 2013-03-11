class AddUserIdToDemographicInfos < ActiveRecord::Migration
  def change
    add_column :demographic_infos, :user_id, :integer
  end
end
