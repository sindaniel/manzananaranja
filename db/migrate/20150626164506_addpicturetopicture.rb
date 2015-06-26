class Addpicturetopicture < ActiveRecord::Migration
  def change
    add_attachment :pictures, :picture
  end
end
