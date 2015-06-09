class Soup < ActiveRecord::Base

  has_many :menusoups
  has_many :menu, through: :menusoups

end
