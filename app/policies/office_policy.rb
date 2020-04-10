# frozen_string_literal: true

class OfficePolicy < ApplicationPolicy
  def index?
    user.manager? || user.admin?
  end

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
