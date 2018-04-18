class Removecolumninopinion < ActiveRecord::Migration[5.2]
  def change
    remove_column :opinions, :imageable_id
    remove_column :opinions, :imageable_type
  end
end
