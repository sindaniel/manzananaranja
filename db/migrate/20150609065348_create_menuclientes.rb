class CreateMenuclientes < ActiveRecord::Migration
  def change
    create_table :menuclientes do |t|

      t.date :date
      t.belongs_to :protein
      t.belongs_to :wok
      t.belongs_to :salad
      t.belongs_to :soup
      t.belongs_to :carbohidrate
      t.boolean :estado
      t.integer :usuario_id

      t.timestamps
    end
  end
end
