class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
  def to_s
    "R: #{street} - #{neighboard} - Nº:#{number} - #{city} - #{state} - Zip code: #{zip_code}"
  end
end
