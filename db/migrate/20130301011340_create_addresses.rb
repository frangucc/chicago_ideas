class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street_1
      t.string :street_2
      t.string :city
      t.string :zip
      t.string :country
      t.string :state

      t.timestamps
    end
  end
end
