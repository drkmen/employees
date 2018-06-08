class Employee < ApplicationRecord
  include Filterable
  extend FriendlyId

  has_one :image, as: :imageable
  has_many :resource_skills
  has_many :skills, through: :resource_skills
  has_many :projects

  friendly_id :friendly_name, use: :slugged

  devise :invitable, :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  enum role: { other: 0, programmer: 1, manager: 2, team_lead: 3, admin: 4, system_administrator: 5 }
  enum department: { ruby: 0, php: 1, js: 2, sys_admins: 3, managers: 4, other_department: 5 }
  enum office: { managers_office: 0, ruby_office: 1, central: 2, firsts: 3,
                 kruglyash: 4, gamers: 5, admins: 6, remote: 7, lviv: 8 }

  default_scope { where(deleted: false) }
  scope :role, -> (role) { where(role: role) }
  scope :office, -> (office) { where(office: office) }
  scope :department, -> (department) { where(department: department) }
  scope :deleted, -> { unscoped.where(deleted: true) }

  accepts_nested_attributes_for :image, :skills, :resource_skills

  def self.filter_skills(employee, skills_array)
    employee.select do |empl|
      empl if empl.skills.collect(&:name).any? { |skill| skills_array.include?(skill) }
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  def friendly_name
    email.split('@').first.tr('.', '_')
  end

  def avatar
    image&.image_url || 'user.png'
  end

  def delete
    update(deleted: true)
  end

  def restore
    update(deleted: false)
  end
end
