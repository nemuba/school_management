class Student < ApplicationRecord
  has_many :addresses, as: :addressable
  has_many :responsible_legals
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :responsible_legals
end
