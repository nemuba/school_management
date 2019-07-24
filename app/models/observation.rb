class Observation < ApplicationRecord
  validates_presence_of :description, :date_observation
  belongs_to :user
  belongs_to :school_class
end
