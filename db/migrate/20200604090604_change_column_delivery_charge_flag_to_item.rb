class ChangeColumnDeliveryChargeFlagToItem < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :delivery_charge_flag, :integer
  end
end
