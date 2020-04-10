# frozen_string_literal: true

class ArchivePolicy < ApplicationPolicy
  def index?
    user.manager? || user.admin? || user.team_lead?
  end

  def restore?
    user.manager? || user.admin? || user.team_lead?
  end

  def destroy?
    user.manager? || user.admin?
  end
end
