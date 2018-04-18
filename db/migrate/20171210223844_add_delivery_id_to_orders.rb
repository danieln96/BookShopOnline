class AddDeliveryIdToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :delivery_id, :integer
  end
end
