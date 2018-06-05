class Skill < ApplicationRecord
  has_many :resource_skills
  has_many :employees, through: :resource_skills
  has_many :projects, through: :resource_skills

  validates :name, presence: true, uniqueness: true
end
