# frozen_string_literal: true

# Sessions Controller
class SessionsController < Devise::SessionsController
  respond_to :html, :json
end
