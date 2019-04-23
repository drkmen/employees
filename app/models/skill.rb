# frozen_string_literal: true

class Skill < ApplicationRecord
  has_many :resource_skills, dependent: :destroy
  has_many :employees, through: :resource_skills
  has_many :projects, through: :resource_skills
  belongs_to :employee, optional: true

  enum skill_type: %i[programming_language framework database library service other_skill]

  validates :name, presence: true, uniqueness: true
end
