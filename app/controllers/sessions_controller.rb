# # frozen_string_literal: true
#
# # Sessions Controller
class SessionsController < Devise::SessionsController
  respond_to :html, :json, :js

  def create
    @referer = request.referer || root_path
    self.resource = warden.authenticate(auth_options)
    if resource && resource.active_for_authentication?
      sign_in(resource_name, resource)
    else
      @errors = 'Wrong credentials'
    end
  end
end
