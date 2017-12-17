class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.string  :type
      t.decimal :price
    end
  end
end
