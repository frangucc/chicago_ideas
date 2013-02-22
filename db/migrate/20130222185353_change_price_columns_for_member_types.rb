class ChangePriceColumnsForMemberTypes < ActiveRecord::Migration
  def up
    change_table :member_types do |t|
      t.rename  :price_in_cents, :min_price_in_cents
      t.rename  :name, :title
      t.integer :max_price_in_cents, default: 0
      t.string  :value, :length => 10
    end
  end

  def down
    rename_column :member_types, :min_price_in_cents, :price_in_cents
    rename_column :member_types, :title, :price
    remove_column :member_types, :max_price_in_cents
    remove_column :member_types, :value
  end
end
