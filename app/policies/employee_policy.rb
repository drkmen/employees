# frozen_string_literal: true

class EmployeePolicy < ApplicationPolicy
  attr_reader :employee, :else_employee

  def initialize(employee, else_employee)
    @employee = employee
    @else_employee = else_employee
  end

  def index?
    employee.manager? || employee.team_lead? || employee.admin?
  end

  def show?
    employee == else_employee || employee.admin? || employee.manager? ||
      (employee.team_lead? && employee.department == else_employee.department)
  end

  def update?
    employee == else_employee || employee.admin? ||
      (employee.manager? && (else_employee.developer? || else_employee.team_lead?)) ||
      (employee.team_lead? && employee.department == else_employee.department && else_employee.developer?)
  end

  def destroy?
    employee.admin? || employee.manager? ||
      (employee.team_lead? && employee.department == else_employee.department)
  end

  def restore?
    employee.admin? || employee.manager? ||
      (employee.team_lead? && employee.department == else_employee.department)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
