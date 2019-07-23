class Presence < ApplicationRecord
  enum status: [:present, :lack]
  belongs_to :student
  belongs_to :school_class
  belongs_to :user # referencia

  def display
    "#{self.model_name.human.titleize} - #{self.student.name.truncate(10)} - #{I18n.l self.date_presence} "
  end
end
