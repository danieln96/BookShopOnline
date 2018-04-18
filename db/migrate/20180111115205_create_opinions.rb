class CreateOpinions < ActiveRecord::Migration[5.2]
  def change
    create_table :opinions do |t|
      t.text  :description
      t.integer :rate
      t.timestamps
    end
  end
end
