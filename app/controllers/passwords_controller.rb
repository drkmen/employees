# frozen_string_literal: true

class PasswordsController < Devise::PasswordsController
  def create
    @referer = request.referer || root_path
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    if successfully_sent?(resource)
      respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
    else
      @errors = 'Wrong credentials'
    end
  end

  protected

  def after_sending_reset_password_instructions_path_for(resource_name)
    root_path
  end

  def after_resetting_password_path_for(resource)
    root_path
  end
end