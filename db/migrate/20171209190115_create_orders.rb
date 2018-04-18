class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
        t.decimal :total
        t.string  :status
        t.integer :user_id
        t.timestamps
        
    end
  end
end
