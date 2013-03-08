class CreateDemographicInfos < ActiveRecord::Migration
  def change
    create_table :demographic_infos do |t|
      t.string :race
      t.string :industry
      t.string :income
      t.string :gender
      t.string :age
      t.string :travel

      t.timestamps
    end
  end
end
