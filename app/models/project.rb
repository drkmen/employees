# frozen_string_literal: true

class Project < ApplicationRecord
  after_save :add_skills_to_employee
  has_one :image, as: :imageable, dependent: :destroy
  has_many :resource_skills, dependent: :destroy
  has_many :skills, through: :resource_skills

  belongs_to :employee
  belongs_to :developer, class_name: 'Employee', foreign_key: :employee_id # alias
  belongs_to :manager, class_name: 'Employee', foreign_key: :manager_id, optional: true

  accepts_nested_attributes_for :image, :skills

  validates :name, presence: true

  def avatar
    image&.image_url || 'placeholder.png'
  end

  private

  def add_skills_to_employee
    employee.skills << (skills - employee.skills)
  end
end
