# frozen_string_literal: true

# Project model
class Project < ApplicationRecord
  has_one :image, as: :imageable, dependent: :destroy
  has_many :resource_skills, dependent: :destroy
  has_many :skills, through: :resource_skills
  validates :name, presence: true

  belongs_to :employee

  accepts_nested_attributes_for :image, :skills

  def avatar
    image&.image_url || 'placeholder.png'
  end
end
