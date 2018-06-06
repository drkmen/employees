class Employee < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  default_scope { where(deleted: false) }
  scope :deleted, -> { unscoped.where(deleted: true) }

  devise :invitable, :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  has_one :image, as: :imageable
  has_many :resource_skills
  has_many :skills, through: :resource_skills
  has_many :projects

  enum role: { other: 0, programmer: 1, manager: 2, team_lead: 3, admin: 4 }
  enum department: { ruby: 0, php: 1, js: 2, other_department: 3 }

  def name
    "#{first_name} #{last_name}"
  end

  def image
    super || 'user.png'
  end

  def delete
    update(deleted: true)
  end

  def restore
    update(deleted: false)
  end
end
