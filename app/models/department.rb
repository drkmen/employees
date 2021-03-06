# frozen_string_literal: true

class Department < ApplicationRecord
  has_many :offices
  has_many :employees
  belongs_to :team_lead, class_name: 'Employee', optional: true

  before_save :set_uid
  after_save :set_team_lead

  validates :name, presence: true
  validates :name, :uid, uniqueness: true

  private

  def set_uid
    self.uid = name.downcase.to_sym
  end

  def set_team_lead
    Employee.find(self.team_lead_id).update_attributes(department: self) if self.team_lead_id
  end
end
