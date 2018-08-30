# frozen_string_literal: true

class EmployeePolicy < ApplicationPolicy
  attr_reader :employee, :else_employee

  def initialize(employee, else_employee)
    @employee = employee
    @else_employee = else_employee
  end

  def index?
    true
  end

  def show?
    true
  end

  def edit?
    false
  end

  def create?
    employee.present? && (employee.admin? || employee.manager?)
  end

  def update?
    employee.present? && (employee == else_employee ||
      employee.admin? || (employee.manager? && (else_employee.developer? || else_employee.team_lead?)) ||
      (employee.team_lead? && employee.department == else_employee.department && else_employee.developer?))
  end

  def destroy?
    create?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
