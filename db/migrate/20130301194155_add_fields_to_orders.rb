class AddFieldsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :authnet_response, :text
    add_column :orders, :address_id, :integer
    add_column :orders, :code, :string, size: 8
    add_column :orders, :name_on_card, :string
  end
  Order.delete_all
end
