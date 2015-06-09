class CreateMenusalads < ActiveRecord::Migration
  def change
    create_table :menusalads do |t|

      t.belongs_to :salad
      t.belongs_to :menu

      t.timestamps
    end
  end
end
