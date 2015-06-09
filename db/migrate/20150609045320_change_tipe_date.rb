class ChangeTipeDate < ActiveRecord::Migration
  def change
    change_column :menus, :date, :date

  end
end
