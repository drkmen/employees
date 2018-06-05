class ProjectPolicy < ApplicationPolicy
  attr_reader :employee, :project

  def initialize(employee, project)
    @employee = employee
    @project = project
  end

  def create?
    employee.present? && ((employee == project.employee && (project.employee.programmer? || project.employee.team_lead?)) ||
      (employee.manager? && project.employee.programmer?) ||
      (employee.team_lead? && project.employee.programmer? &&
        project.employee.department == employee.department) ||
      (employee.admin? && (project.employee.programmer? || project.employee.team_lead?)))
  end

  def update?
    employee.present? && ((employee == project.employee && (project.employee.programmer? || project.employee.team_lead?)) ||
      (employee.manager? && project.employee.programmer?) ||
      (employee.team_lead? && project.employee.programmer? &&
        project.employee.department == employee.department) ||
      (employee.admin? && (project.employee.programmer? || project.employee.team_lead?)))
  end

  def destroy?
    employee.present? && ((employee == project.employee && (project.employee.programmer? || project.employee.team_lead?)) ||
      (employee.manager? && project.employee.programmer?) ||
      (employee.team_lead? && project.employee.programmer? &&
        project.employee.department == employee.department) ||
      (employee.admin? && (project.employee.programmer? || project.employee.team_lead?)))
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
