class Menuprotein < ActiveRecord::Base
  belongs_to :protein
  belongs_to :menu
end
