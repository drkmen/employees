# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_employee_location!, if: :storable_location?
  before_action :authenticate_employee!

  rescue_from ActiveRecord::RecordInvalid, with: :validation_handler
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized_handler

  def wishes
    flash[:success] = 'Successful sent' if ApplicationMailer.send_wish(current_employee, params[:wish]).deliver_now
    redirect_to root_path
  end

  alias_method :current_user, :current_employee

  protected

  def root_path
    return super unless current_employee

    current_employee.developer_without_ap? ||
      current_employee.other? ||
      current_employee.system_administrator? ? employee_path(current_employee) : super
  end

  def after_sign_out_path_for(_resource_or_scope)
    URI.parse(request.referer).path || root_path
  rescue => _
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: %i[first_name last_name role department_id])
  end

  def load_data
    @skills = Skill.all.order(skill_type: :asc)
    return if current_employee.developer_without_ap?

    @employees = Employee.all
    @employees = @employees.public_send("#{current_employee.department.uid}_dep") if current_employee.team_lead? && !current_employee.admin?

    if params[:term]
      @employees = @employees.search(params[:term])
    else
      @employees = @employees.includes(:skills, :department).filter(params.reject { |_, v| v.blank? }
                                                         .slice(:role, :office, :department, :status))
      @employees = @employees.filter_skills(@employees, params[:skills]) if params[:skills]
    end

    @employees = @employees.to_a.group_by(&:department) unless @employees.empty?
  end

  private

  def storable_location?
    request.get? && is_navigational_format? &&
      !devise_controller? && !request.xhr?
  end

  def store_employee_location!
    store_location_for(:employee, request.fullpath)
  end

  def validation_handler(error)
    Bugsnag.notify error
    flash[:danger] = error
    redirect_to(request.referrer || root_path)
  end

  def not_authorized_handler
    flash[:warning] = 'You are not authorized to perform this action.'
    redirect_to employee_path(current_employee)
  end
end
