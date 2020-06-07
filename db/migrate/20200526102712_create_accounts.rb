class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.references :user, foreign_key: true, null: false
      t.string :icon_image
      t.string :background_image
      t.text :introduction
      t.timestamps
    end
  end
end
