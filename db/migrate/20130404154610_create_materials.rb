class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string     :name
      t.attachment :thumbnail
      t.attachment :document

      t.timestamps
    end
  end
end
