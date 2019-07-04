class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :street, :number, :city, :state, :zip_code, :neighboard, presence: true
  def to_s
    "R: #{street} - #{neighboard} - Nº:#{number} - #{city} - #{state} - Zip code: #{zip_code}"
  end
end
