class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :deliveries, :type, :title
  end
end
