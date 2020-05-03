class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :buyer_id, index: true
      t.integer :saler_id, index: true
      # t.references :category, foreign_key: true, null: false
      # t.references :brand, foreign_key: true, null: false
      t.string :name, null: false
      t.text :explanation
      t.string :status, null: false
      t.string :delivery_charge_flag, null: false
      t.integer :prefectures, null: false
      t.string :delivery_date, null: false
      t.integer :price, null: false
      t.string :delivery_method, null: false
      t.timestamps
    end
  end
end
