class RemoveAuthnetResponseFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :authnet_response
  end
end
