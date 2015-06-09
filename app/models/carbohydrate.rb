class Carbohydrate < ActiveRecord::Base
  has_many :menucarbohydrates
  has_many :menu, through: :menucarbohydrates
end
