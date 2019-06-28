class Student < ApplicationRecord
  has_many :addresses, as: :addressable
  accepts_nested_attributes_for :addresses
end
