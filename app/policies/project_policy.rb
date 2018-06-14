# frozen_string_literal: true

# ProjectPolicy
class ProjectPolicy < ApplicationPolicy
  attr_reader :employee, :project

  def initialize(employee, project)
    @employee = employee
    @project = project
  end

  def edit?
    false
  end

  def create?
    employee.present? && (employee == project.employee ||
      (employee.manager? && (project.employee.programmer? || project.employee.team_lead?)) ||
      (employee.team_lead? && project.employee.programmer? &&
          project.employee.department == employee.department) ||
      employee.admin?)
  end

  def update?
    create?
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
