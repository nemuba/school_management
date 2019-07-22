class Activity < ApplicationRecord
  enum fields_of_expertise: [:eo, :cg, :ts]
  belongs_to :user
  belongs_to :school_class

  def to_s
    "#{self.fields_of_expertise.upcase} - #{self.description[0,25].html_safe}"
  end
end
