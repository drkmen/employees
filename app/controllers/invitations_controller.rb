# frozen_string_literal: true

# Invitations Controller
class InvitationsController < Devise::InvitationsController
  respond_to :html, :json
end
