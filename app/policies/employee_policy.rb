class EmployeePolicy < ApplicationPolicy
  attr_reader :employee, :else_employee

  def initialize(employee, else_employee)
    @employee = employee
    @else_employee = else_employee
  end

  def create?
    employee.present? && employee.admin?
  end

  def update?
    employee.present? && (employee == else_employee ||
      employee.admin? || (employee.manager? && else_employee.programmer?) ||
      (employee.team_lead? && employee.department == else_employee.department && else_employee.programmer?))
  end

  def destroy?
    employee.present? && employee.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
