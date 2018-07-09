# frozen_string_literal: true

class InvitationsController < Devise::InvitationsController
  respond_to :html, :json
end
