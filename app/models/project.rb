# frozen_string_literal: true

class Project < ApplicationRecord
  after_save :add_skills_to_employee
  has_one :image, as: :imageable, dependent: :destroy
  has_many :resource_skills, dependent: :destroy
  has_many :skills, through: :resource_skills

  belongs_to :employee, optional: true
  has_many :employee_projects
  has_many :employees, through: :employee_projects, source: :employee

  belongs_to :developer, class_name: 'Employee', foreign_key: :employee_id
  belongs_to :manager, class_name: 'Employee', foreign_key: :manager_id, optional: true

  accepts_nested_attributes_for :image, :skills

  validates :name, presence: true

  def add_skills_to_employee
    employee.skills << (skills - employee.skills)
  end

  def avatar
    image&.image_url || 'placeholder.png'
  end
end
