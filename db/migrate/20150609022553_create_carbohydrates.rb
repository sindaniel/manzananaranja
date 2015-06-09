class CreateCarbohydrates < ActiveRecord::Migration
  def change
    create_table :carbohydrates do |t|
      t.string :name

      t.timestamps
    end
  end
end
