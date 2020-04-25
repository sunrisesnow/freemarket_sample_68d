class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :user_id,           null: false
      t.string :last_name,          null: false
      t.string :first_name,         null: false
      t.string :last_name_kana,     null: false
      t.string :first_name_kana,    null: false
      t.string :postal_code,        null: false
      t.string :prefectures,        null: false
      t.string :municipality,       null: false
      t.string :address,            null: false
      t.string :building           
      t.string :phone_number      

      t.timestamps null: false
    end
  end
end
