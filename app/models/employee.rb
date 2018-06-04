class Employee < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  default_scope { where(deleted: false) }
  scope :deleted, -> { unscoped.where(deleted: true) }


  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  has_one :image, as: :imageable
  has_many :resource_skills, as: :skillable
  has_many :skills, through: :resource_skills

  def name
    "#{first_name} #{last_name}"
  end

  def image
    super || 'user.png'
  end

  def delete
    update(deleted: true)
  end
end
