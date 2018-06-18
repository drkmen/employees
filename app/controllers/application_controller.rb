# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_employee_location!, if: :storable_location?
  before_action :authenticate_employee!

  protected

  def after_sign_out_path_for(resource_or_scope)
    URI.parse(request.referer).path || root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: %i[first_name last_name role])
  end

  private

  def storable_location?
    request.get? && is_navigational_format? &&
      !devise_controller? && !request.xhr?
  end

  def store_employee_location!
    store_location_for(:employee, request.fullpath)
  end
end
