class ChangeDataCheckedToNotifications < ActiveRecord::Migration[5.2]
  def up
    change_column :notifications, :checked, :boolean, default: false, null: false
  end

  def down
    change_column :notifications, :checked, :boolean, null: true
  end
end
