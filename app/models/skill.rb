# frozen_string_literal: true

# Skill model
class Skill < ApplicationRecord
  has_many :resource_skills
  has_many :employees, through: :resource_skills
  has_many :projects, through: :resource_skills
  validates :name, presence: true, uniqueness: true
  enum skill_type: { other_skill: 0,
                     programming_language: 1,
                     library: 2,
                     framework: 3,
                     service: 4,
                     database: 5 }

  def experience(employee_id)
    resource_skills.find_by(employee_id: employee_id)&.experience
  end
end
