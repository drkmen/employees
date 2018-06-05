class Skill < ApplicationRecord
  has_many :resource_skills
  has_many :employees, through: :resource_skills, source: :skillable, source_type: 'Employee'
  has_many :projects, through: :resource_skills, source: :skillable, source_type: 'Project'

  validates :name, presence: true, uniqueness: true
end
