class CreateMenuwoks < ActiveRecord::Migration
  def change
    create_table :menuwoks do |t|

      t.belongs_to :menu
      t.belongs_to :wok

      t.timestamps
    end
  end
end
