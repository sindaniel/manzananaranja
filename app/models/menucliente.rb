class Menucliente < ActiveRecord::Base


  belongs_to :wok
  belongs_to :soup
  belongs_to :protein
  belongs_to :carbohydrate
  belongs_to :salad



  def self.as_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |item|
        csv << item.attributes.values_at(*column_names)
      end
    end
  end


end
