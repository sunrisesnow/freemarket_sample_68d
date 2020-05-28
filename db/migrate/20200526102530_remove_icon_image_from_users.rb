class RemoveIconImageFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :icon_image, :string
  end
end
