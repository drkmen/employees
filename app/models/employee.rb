class Employee < ApplicationRecord
  acts_as_paranoid

  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  has_one :image, as: :imageable
  has_many :resource_skills, as: :skillable
  has_many :skills, through: :resource_skills
end
