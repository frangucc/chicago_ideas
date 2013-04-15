class CreateSponsorEvents < ActiveRecord::Migration

  def change
    create_table :sponsor_events do |t|
      t.string :month
      t.string :day
      t.string :name
      t.string :info

      t.timestamps
    end
  end

end
