class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  enum kind: [:admin, :director, :vice_director,:coordinator, :teacher, :secretary]
  enum job_role: [:peb1, :peb2, :pdi, :amanuensis]

  has_many :addresses, as: :addressable
  accepts_nested_attributes_for :addresses

  def to_s
    "#{name} #{(kind.nil?) ? kind : " - #{kind.upcase}"} #{(job_role.nil?) ? job_role : " - #{job_role.upcase}"}"
  end
end
