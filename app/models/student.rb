class Student < ApplicationRecord
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :responsible_legals

  has_many :registrations, dependent: :destroy
  has_many :school_classes, through: :registrations, dependent: :destroy

  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :responsible_legals

  validates :name,:father, :mother, :birthdate, :ra, :rm, :phone, :number_registration, :addresses, presence: true
end
