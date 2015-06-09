class Salad < ActiveRecord::Base

  has_many :menusalads
  has_many :menu, through: :menusalads


end
