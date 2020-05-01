class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :buyer_id,            foreign_key: true
      t.integer :saler_id,            foreign_key: true, null: false
      t.integer :category_id,         foreign_key: true, null: false
      t.integer :brand_id,            foreign_key: true, null: false
      t.string :name,                 null: false
      t.text :explaination,           null: false
      t.string :status,               null: false
      t.string :delivery_charge_flag, null: false
      t.integer :prefectures,         null: false
      t.string :delivery_data,        null: false
      t.integer :price,               null: false
      t.string :delivery_method,      null: false

      t.timestamps
    end
  end
end
