class SkillPolicy < ApplicationPolicy
  attr_reader :employee, :skill

  def initialize(employee, skill)
    @employee = employee
    @skill = skill
  end

  def create?
    employee.present?
  end

  def update?
    employee.present?
  end

  def destroy?
    employee.present?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
