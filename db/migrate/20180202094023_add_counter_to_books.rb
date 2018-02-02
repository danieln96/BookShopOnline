class AddCounterToBooks < ActiveRecord::Migration
  def change
    add_column :books, :counter, :integer, default: 0
  end
end
