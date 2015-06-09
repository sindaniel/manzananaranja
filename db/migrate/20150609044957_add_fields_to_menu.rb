class AddFieldsToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :estado, :boolean
  end
end
