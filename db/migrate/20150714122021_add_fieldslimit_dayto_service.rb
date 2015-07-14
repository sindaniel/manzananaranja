class AddFieldslimitDaytoService < ActiveRecord::Migration
  def change
    add_column  :services, :limite, :integer
  end
end
