class ChangeColumnToNotNull < ActiveRecord::Migration[5.2]
  def up
    change_column :items, :saler_id, :integer, null: true
  end

  def down
    change_column :items, :saler_id, :integer, null: false
  end
end