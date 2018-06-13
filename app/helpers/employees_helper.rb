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
    current_employee == @employee || current_employee&.admin? ||
      current_employee&.manager? || current_employee&.team_lead?
  end
end
