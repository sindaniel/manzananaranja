class UpdateTableMenuProntein < ActiveRecord::Migration
  def change

    add_reference :menuproteins, :protein, index: true
    add_reference = add_reference :menuproteins, :menu, index: true
    add_reference
  end
end
