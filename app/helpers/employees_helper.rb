# frozen_string_literal: true

# EmployeeHelper
module EmployeesHelper
  def role(employee)
    return 'Owner' if employee.admin?
    employee.role.humanize
  end

  def able_edit
    return unless block_given?
    yield if able_edit?
  end

  def able_edit?
    current_employee == @employee ||
      current_employee&.admin? ||
      (current_employee&.manager? && (@employee.developer? || @employee.team_lead?)) ||
      (current_employee&.team_lead? && current_employee&.department == @employee.department && @employee.developer?)
  end

  def able_change_role?
    current_employee&.manager? || current_employee&.admin?
  end

  def pluralize(body, size = nil)
    return body.pluralize unless size
    parts = super(size, body).split
    "#{ parts&.last&.capitalize } (#{ parts&.first })"
  end
end
