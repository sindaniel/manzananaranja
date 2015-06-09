class CreateWoks < ActiveRecord::Migration
  def change
    create_table :woks do |t|
      t.string :name

      t.timestamps
    end
  end
end
