class ImagePolicy < ApplicationPolicy
  attr_reader :employee, :image

  def initialize(employee, image)
    @employee = employee
    @image = image
  end

  def create?
    employee.present? && (employee == image.imageable ||
      (image.imageable.programmer? &&
        ((employee.team_lead? && image.imageable.department == employee.department) ||
          employee.manager?)) ||
      employee.admin?)
  end

  def update?
    employee.present? && (employee == image.imageable ||
      (image.imageable.programmer? &&
        ((employee.team_lead? && image.imageable.department == employee.department) ||
          employee.manager?)) ||
      employee.admin?)
  end

  def destroy?
    employee.present? && (employee == image.imageable ||
      (image.imageable.programmer? &&
        ((employee.team_lead? && image.imageable.department == employee.department) ||
          employee.manager?)) ||
      employee.admin?)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
