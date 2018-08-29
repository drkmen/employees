# frozen_string_literal: true

class ImagePolicy < ApplicationPolicy
  attr_reader :employee, :image

  def initialize(employee, image)
    @employee = employee
    @image = image
  end

  def create?
    if image&.imageable.instance_of? Employee
      employee.present? && (employee == image.imageable ||
          (image.imageable.developer? &&
              ((employee.team_lead? && image.imageable.department == employee.department) ||
                  employee.manager?)) ||
          employee.admin?)
    elsif image&.imageable.instance_of? Project
      employee.present? && (employee == image.imageable.employee ||
          (image.imageable.employee.developer? &&
              ((employee.team_lead? && image.imageable.employee.department == employee.department) ||
                  employee.manager?)) ||
          employee.admin?)
    end
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
