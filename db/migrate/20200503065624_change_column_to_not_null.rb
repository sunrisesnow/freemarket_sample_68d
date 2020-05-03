class ChangeColumnToNotNull < ActiveRecord::Migration[5.2]
  def change
    def up
      change_column :imtes, :saler_id, :string, null: true
    end
  
    def down
      change_column :items, :saler_id, :string, null: false
    end
  end
end