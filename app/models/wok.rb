class Wok < ActiveRecord::Base

  has_many :menuwoks
  has_many :menu, through: :menuwoks
end
