class ChangeDemographicInfosTravelToBool < ActiveRecord::Migration
  def change
    change_column :demographic_infos, :travel, :bool, :default => false
  end
end
