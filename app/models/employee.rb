# frozen_string_literal: true

class Employee < ApplicationRecord
  include Filterable
  extend FriendlyId

  FILTERS = %i[role office department status]

  has_many :resource_skills, dependent: :destroy
  has_many :skills, through: :resource_skills

  has_many :projects, dependent: :destroy
  has_many :active_projects, ->{ where(active: true) }, class_name: 'Project', dependent: :destroy
  has_many :manager_active_projects, ->{ where(active: true) },
           class_name: 'Project', dependent: :destroy, foreign_key: :manager_id

  has_many :own_skills, class_name: 'Skill'

  has_many :manager_developers, foreign_key: :manager_id, class_name: 'EmployeeManager'
  has_many :developers, through: :manager_developers, source: :developer

  has_many :developer_managers, foreign_key: :developer_id, class_name: 'EmployeeManager'
  has_many :managers, through: :developer_managers, source: :manager

  has_one :image, as: :imageable, dependent: :destroy
  belongs_to :office, counter_cache: true, optional: true
  belongs_to :department, counter_cache: true, optional: true

  friendly_id :friendly_name, use: :slugged

  devise :invitable, :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  enum role: %i[other developer manager team_lead admin system_administrator]
  enum status: %i[free partially_busy busy]

  default_scope { where(deleted: false) }

  FILTERS.each do |filter|
    scope filter, ->(value) { where(filter => value)}
  end

  Department.all.each do |department|
    scope "#{department.uid}_dep", ->() { where(department_id: department.id) }
  end

  scope :deleted, -> { unscoped.where(deleted: true) }
  scope :search, ->(term) do
    return all unless term
    where("(first_name ILIKE ?) OR ((first_name || ' ' || last_name) ILIKE ?)", "%#{term}%", "%#{term}%")
  end

  accepts_nested_attributes_for :image, :skills, :resource_skills

  def self.filter_skills(employee, skills_array)
    employee.select do |empl|
      empl if empl.skills.collect(&:name).any? do |skill|
        skills_array.include?(skill)
      end
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

  def admin?
    super || self.grant_admin_permissions
  end

  def developer_without_ap?
    self.developer? && !admin?
  end

  def self.me
    find_by(email: ENV['MY_EMAIL'])
  end
end
