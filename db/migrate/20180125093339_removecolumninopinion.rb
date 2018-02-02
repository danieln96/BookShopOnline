class Removecolumninopinion < ActiveRecord::Migration
  def change
    remove_column :opinions, :imageable_id
    remove_column :opinions, :imageable_type
  end
end
