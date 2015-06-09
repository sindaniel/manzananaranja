class CreateProteins < ActiveRecord::Migration
  def change
    create_table :proteins do |t|
      t.string :name

      t.timestamps
    end
  end
end
