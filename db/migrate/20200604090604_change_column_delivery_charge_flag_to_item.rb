class ChangeColumnDeliveryChargeFlagToItem < ActiveRecord::Migration[5.2]
  def up
    change_column :items, :delivery_charge_flag, :integer
  end

  def down
    change_column :items, :delivery_charge_flag, :string
  end
end
