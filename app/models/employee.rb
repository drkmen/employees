class Employee < ApplicationRecord
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  has_one :image, as: :imageable
  has_many :resource_skills, as: :skillable
  has_many :skills, through: :resource_skills

  def name
    "#{first_name} #{last_name}"
  end

  def image
    super || 'user.png'
  end
end
