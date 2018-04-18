class EditTables < ActiveRecord::Migration[5.2]
  def change
    add_reference :opinions, :imageable, :polymorphic => true
  end
end
