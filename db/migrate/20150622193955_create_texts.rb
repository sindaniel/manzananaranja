class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.string :title
      t.text :description
      t.integer :category

      t.timestamps
    end
  end
end
