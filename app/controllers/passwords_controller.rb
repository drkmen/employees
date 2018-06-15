# frozen_string_literal: true

# PasswordsController
class PasswordsController < Devise::PasswordsController
  protected

  def after_sending_reset_password_instructions_path_for(resource_name)
    root_path
  end

  def after_resetting_password_path_for(resource)
    root_path
  end
end