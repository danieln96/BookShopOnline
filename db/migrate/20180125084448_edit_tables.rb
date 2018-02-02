class EditTables < ActiveRecord::Migration
  def change
    add_reference :opinions, :imageable, :polymorphic => true
  end
end
