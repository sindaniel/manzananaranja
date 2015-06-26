class Service < ActiveRecord::Base


  has_many :plancliente
  has_many :customers, through: :plancliente



  validates :dishes,  presence: true


end
