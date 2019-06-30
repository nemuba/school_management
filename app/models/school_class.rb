class SchoolClass < ApplicationRecord
  enum period:[:integral, :tarde, :manha, :parcial]
  belongs_to :user, optional: true

  def to_s
    "#{series} - #{period} - #{year_school.strftime('%Y')}"
  end

end
