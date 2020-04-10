# frozen_string_literal: true

class InvitationsController < Devise::InvitationsController
  respond_to :html, :json

  private

  def after_accept_path_for(_resource)
    root_path
  end
end
