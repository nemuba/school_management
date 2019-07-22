class Presence < ApplicationRecord
  enum status: [:present, :lack]
  belongs_to :student
  belongs_to :school_class
  belongs_to :user # referencia
end
