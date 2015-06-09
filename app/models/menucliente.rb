class Menucliente < ActiveRecord::Base


  belongs_to :wok
  belongs_to :soup
  belongs_to :protein
  belongs_to :carbohydrate
  belongs_to :salad

end
