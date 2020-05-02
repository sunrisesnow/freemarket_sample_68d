class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :buyer_id
      t.integer :seller_id
      t.integer :category_id
      t.integer :brand_id
      t.string :name
      t.integer :price
      t.string :status
      t.text :explanation
      t.string :delivery_data
      t.string :delivery_method
      t.string :delivery_charge
      t.integer :prefecture

      t.timestamps
    end
  end
end
