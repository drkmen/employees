# frozen_string_literal: true

module EmployeesHelper
  def root_path
    return super unless current_employee

    current_employee.developer_without_ap? ||
      current_employee.other? ||
      current_employee.system_administrator? ? employee_path(current_employee) : super
  end

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

  def departments_for_select
    collection = Department.all
    collection = collection.where(id: current_employee.department.id) if current_employee.team_lead_without_ap?
    collection.order(employees_count: :desc).map { |department| [department.name, department.id] }
  end

  def roles_for_select
    current_employee.team_lead_without_ap? ? %i[developer] : Employee::ROLES
  end

  def team_leads_for_select
    Employee.team_lead.map { |team_lead| [team_lead.name, team_lead.id] }
  end
end
