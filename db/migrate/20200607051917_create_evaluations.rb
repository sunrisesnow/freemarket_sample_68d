class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.references :user,  foreign_key: true,                 null: false
      t.references :saler, foreign_key: { to_table: :users }, null: false
      t.references :buyer, foreign_key: { to_table: :users }, null: false
      t.text       :comment
      t.integer    :evaluation,                               null: false
      t.timestamps
    end
  end
end
