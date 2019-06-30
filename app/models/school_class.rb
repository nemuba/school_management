class SchoolClass < ApplicationRecord
  enum period:[:integral, :tarde, :manha, :parcial]
  belongs_to :user, optional: true

  scope :period_integral, -> {where(period: :integral)}
  scope :period_manha, -> {where(period: :manha)}
  scope :period_tarde, -> {where(period: :tarde)}
  scope :period_parcial, -> {where(period: :parcial)}

  def to_s
    "#{series} - #{period} - #{year_school.strftime('%Y')}"
  end

end
