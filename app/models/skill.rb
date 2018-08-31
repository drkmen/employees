# frozen_string_literal: true

class Skill < ApplicationRecord
  has_many :resource_skills, dependent: :destroy
  has_many :employees, through: :resource_skills
  has_many :projects, through: :resource_skills
  belongs_to :employee, optional: true

  enum skill_type: %i[programming_language framework database library service other_skill]

  scope :sorted, ->(employee_id) { sort_by { |skill| skill.level(employee_id) }.reverse }

  validates :name, presence: true, uniqueness: true

  def experience(employee_id)
    employee_resource_skill(employee_id)&.experience
  end

  def level(employee_id)
    employee_resource_skill(employee_id)&.level || 0
  end

  def display_name(employee_id)
    exp = experience employee_id
    return name unless exp.present?
    "#{name} / #{exp}"
  end

  private

  def employee_resource_skill(employee_id)
    resource_skills.find_by(employee_id: employee_id)
  end
end
