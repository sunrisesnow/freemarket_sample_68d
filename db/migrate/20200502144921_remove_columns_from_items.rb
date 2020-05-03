class RemoveColumnsFromItems < ActiveRecord::Migration[5.2]
  def up
    remove_column :items, :status
    remove_column :items, :prefectures
    remove_column :items, :delivery_date
    remove_column :items, :delivery_method
  end
end
