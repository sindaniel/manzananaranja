class CreateMenusoups < ActiveRecord::Migration
  def change
    create_table :menusoups do |t|

      t.belongs_to :menu
      t.belongs_to :soup

      t.timestamps
    end
  end
end
