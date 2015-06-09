class Protein < ActiveRecord::Base
  has_many :menuproteins
  has_many :menu, through: :menuproteins

end
