# frozen_string_literal: true

module EmployeesHelper
  def root_path
    current_employee.developer_without_ap? ||
      current_employee.other? ||
      current_employee.system_administrator? ? employee_path(current_employee) : super
  end

  def role(employee)
    return 'Owner' if employee.role == 'admin'

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
