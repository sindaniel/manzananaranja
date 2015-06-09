class CreateMenucarbohydrates < ActiveRecord::Migration
  def change
    create_table :menucarbohydrates do |t|

      t.belongs_to :menu
      t.belongs_to :carbohydrates

      t.timestamps
    end
  end
end
