class Project < ApplicationRecord
  has_one :image, as: :imageable
  has_many :resource_skills
  has_many :skills, through: :resource_skills
  validates :name, presence: true

  belongs_to :employee

  accepts_nested_attributes_for :image, :skills

  def avatar
    image&.image_url || 'project.png'
  end
end
