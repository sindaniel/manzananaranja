class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.integer :dishes
      t.integer :discount
      t.integer :price

      t.timestamps
    end
  end
end
