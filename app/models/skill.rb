# frozen_string_literal: true

# Skill model
class Skill < ApplicationRecord
  has_many :resource_skills, dependent: :destroy
  has_many :employees, through: :resource_skills
  has_many :projects, through: :resource_skills

  enum skill_type: %i[programming_language framework database library service other_skill]

  validates :name, presence: true, uniqueness: true

  def experience(employee_id)
    resource_skills.find_by(employee_id: employee_id)&.experience
  end

  def display_name(employee_id)
    exp = experience employee_id
    return name unless exp
    "#{name} / #{exp}"
  end
end
