class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :item_id
      t.string :action
      t.boolean :checked, default: false, null: false
      t.timestamps
    end
  end
end
