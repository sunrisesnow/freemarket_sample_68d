class RemoveColumnsInNotifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications, :like_id, :integer
    remove_column :notifications, :comment_id, :integer
  end
end
