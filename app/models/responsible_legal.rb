class ResponsibleLegal < ApplicationRecord
  validates_presence_of :name
  belongs_to :student
end
