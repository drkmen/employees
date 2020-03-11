# frozen_string_literal: true

class ArchivePolicy < ApplicationPolicy
  def index?
    user.manager? || user.admin?
  end
end
