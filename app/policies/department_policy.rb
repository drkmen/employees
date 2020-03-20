# frozen_string_literal: true

class DepartmentPolicy < ApplicationPolicy
  def create?
    user.manager? || user.admin?
  end

  def update?
    user.manager? || user.admin?
  end

  def destroy?
    user.manager? || user.admin?
  end
end
