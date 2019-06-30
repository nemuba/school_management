class Registration < ApplicationRecord
  enum status:[:active, :transferred]
  belongs_to :school_class
  belongs_to :student

  def to_s
    "#{self.school_class.to_s}"
  end
end
