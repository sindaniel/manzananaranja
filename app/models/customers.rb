class Customers < ActiveRecord::Base
 # belongs_to :plancliente

  has_many :plancliente
  has_many :service, through: :plancliente

end
