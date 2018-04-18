class CreateBookOpinions < ActiveRecord::Migration[5.2]
  def change
    create_table :book_opinions do |t|
      t.integer :book_id
      t.integer :user_id
      t.integer :opinion_id
    end
  end
end
