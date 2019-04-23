# frozen_string_literal: true

class ResourceSkill < ApplicationRecord
  belongs_to :skill, optional: true
  belongs_to :project, optional: true
  belongs_to :employee, optional: true

  validates :level, inclusion: { in: (0..100) }, allow_nil: true

  scope :sorted, ->(employee_id) { sort_by { |rs| rs.level || 0 }.reverse }
end
