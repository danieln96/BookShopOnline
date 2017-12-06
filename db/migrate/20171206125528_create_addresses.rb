class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string  :street
      t.string  :homenumber
      t.string  :apartnumber
      t.string  :postalcode
      t.string  :city
      t.string  :telnumber
      t.integer :user_id
    end
  end
end
