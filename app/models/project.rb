class Project < ApplicationRecord
  has_one :image, as: :imageable
  has_many :resource_skills
  has_many :skills, through: :resource_skills
  validates :name, presence: true

end
