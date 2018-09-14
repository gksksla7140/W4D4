class CreateCat < ActiveRecord::Migration[5.2]
  def change
    create_table :cats do |t|
      t.string :color, null: false
      t.string :name, null: false
      t.date :brith_date, null: false
      t.string :description, null: false
      t.string :sex , null: false
      t.timestamps
      end
  end
end
