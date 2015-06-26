class CreatePlanclientes < ActiveRecord::Migration
  def change
    create_table :planclientes do |t|
      t.string :name
      t.belongs_to :service
      t.belongs_to :customer
      t.integer :estado, :default=> 0

      t.timestamps
    end
  end
end
