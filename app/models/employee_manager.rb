# frozen_string_literal: true

class EmployeeManager < ApplicationRecord
  belongs_to :developer, foreign_key: 'developer_id', class_name: 'Employee'
  belongs_to :manager, foreign_key: 'manager_id', class_name: 'Employee'
end
