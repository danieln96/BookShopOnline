class AddCounterToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :counter, :integer, default: 0
  end
end
