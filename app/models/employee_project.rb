# frozen_string_literal: true

class EmployeeProject < ApplicationRecord
  belongs_to :project
  belongs_to :employee
end
