class SkillPolicy < ApplicationPolicy
  attr_reader :employee, :skill

  def initialize(employee, skill)
    @employee = employee
    @skill = skill
  end

  def edit?
    false
  end

  def create?
    employee.present?
  end

  def update?
    employee.present? && skill.employee_id == employee.id
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
