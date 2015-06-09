class Menu < ActiveRecord::Base
  has_many :menuproteins
  has_many :proteins, through: :menuproteins

  has_many :menucarbohydrates
  has_many :carbohydrates, through: :menucarbohydrates


  has_many :menusalads
  has_many :salads, through: :menusalads

  has_many :menusoups
  has_many :soups, through: :menusoups


  has_many :menuwoks
  has_many :woks, through: :menuwoks
end
