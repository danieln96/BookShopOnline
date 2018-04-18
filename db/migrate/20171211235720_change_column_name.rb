class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :deliveries, :type, :title
  end
end
