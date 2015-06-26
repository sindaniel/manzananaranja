class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :phone
      t.string :password
      t.integer :sex
      t.string :address

      t.timestamps
    end
  end
end
