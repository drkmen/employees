# frozen_string_literal: true

# Project model
class Project < ApplicationRecord
  has_one :image, as: :imageable, dependent: :destroy
  has_many :resource_skills, dependent: :destroy
  has_many :skills, through: :resource_skills
  validates :name, presence: true

  belongs_to :employee
  belongs_to :developer, class_name: 'Employee', foreign_key: :employee_id #alias
  belongs_to :manager, class_name: 'Employee', foreign_key: :manager_id

  accepts_nested_attributes_for :image, :skills

  def avatar
    image&.image_url || 'placeholder.png'
  end
end
