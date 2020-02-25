# frozen_string_literal: true

class Skill < ApplicationRecord
  TYPES = %i[programming_language framework database library service other_skill].freeze

  has_many :resource_skills, dependent: :destroy
  has_many :employees, through: :resource_skills
  has_many :projects, through: :resource_skills
  belongs_to :employee, optional: true

  enum skill_type: TYPES

  validates :name, presence: true, uniqueness: true
end
