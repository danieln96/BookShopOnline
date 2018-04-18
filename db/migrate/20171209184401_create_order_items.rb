class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :book_id
      t.integer :quantity
      t.integer :order_id
    end
  end
end
