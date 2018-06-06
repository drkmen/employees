module EmployeesHelper
  def role(employee)
    return 'Owner' if employee.admin?
    employee.role.humanize
  end
end
