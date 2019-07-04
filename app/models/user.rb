class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  enum status: [:active, :inactive]
  enum kind: [:admin, :director, :vice_director,:coordinator, :teacher, :secretary]
  enum job_role: [:admin_user,:peb1, :peb2, :pdi, :paeb, :amanuensis, :asi]

  has_many :school_classes
  has_many :addresses, as: :addressable
  accepts_nested_attributes_for :addresses

  scope :teachers, -> {where kind: :teacher}
  scope :pebs_1, -> {where job_role: :peb1}
  scope :pebs_2, -> {where job_role: :peb2}
  scope :pdis, -> {where job_role: :pdi}
  scope :paebs, -> {where job_role: :paeb}
  scope :asis, -> {where job_role: :asi}

  validates :name, :kind, :job_role, :status, :registration, :birthdate, presence: true

  def to_s
    "#{self.name} #{(self.kind.nil?) ? self.kind : " - #{self.kind.upcase}"} #{(self.job_role.nil?) ? self.job_role : " - #{self.job_role.upcase}"}"
  end

  def admin?
    (self.kind == "admin") ? true : false
  end

  def teacher?
    (self.kind === "teacher") ? true : false
  end

  def director?
    (self.kind == "director") ? true : false
  end

  def vice_director?
    (self.kind == "vice_director") ? true : false
  end

  def coordinator?
    (self.kind == "coordinator") ? true : false
  end

  def secretary?
    (self.kind == "secretary") ? true : false
  end

end
