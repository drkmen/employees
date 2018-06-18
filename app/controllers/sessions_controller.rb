# # frozen_string_literal: true
#
# # Sessions Controller
class SessionsController < Devise::SessionsController

  def create
    # @referer = request.referer || root_path
    # self.resource = warden.authenticate(auth_options)
    # if resource && resource.active_for_authentication?
    #   sign_in(resource_name, resource)
    #   respond_to do |format|
    #     format.html { redirect_to root_path }
    #     format.js
    #   end
    # else
    #   @errors = 'Wrong credentials'
    #   respond_to do |format|
    #     format.html { redirect_to new_employee_session_path }
    #     format.js
    #   end
    # end
    super
  end
end
