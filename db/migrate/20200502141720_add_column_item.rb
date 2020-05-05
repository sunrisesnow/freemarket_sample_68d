class AddColumnItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :prefecture_id, :integer
    add_column :items, :status_id, :integer
    add_column :items, :delivery_date_id, :integer
    add_column :items, :delivery_method_id, :integer
    add_column :items, :trading_status_id, :integer, default: '1'
  end
end
