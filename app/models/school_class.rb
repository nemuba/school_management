class SchoolClass < ApplicationRecord
  belongs_to :user, optional: true

  def to_s
    "#{series} - #{period} - #{year_school.strftime('%Y')}"
  end
end
