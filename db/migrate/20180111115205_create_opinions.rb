class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
      t.text  :description
      t.integer :rate
      t.timestamps
    end
  end
end
