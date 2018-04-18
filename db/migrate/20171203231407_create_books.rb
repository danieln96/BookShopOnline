class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string  :title
      t.string  :author
      t.string  :publisher
      t.string  :pdate
      t.string  :isbn
      t.string  :pages
      t.integer :copies
      t.decimal :price
      t.timestamps
      
    end
  end
end
