# frozen_string_literal: true

# Employyes Controller
class EmployeesController < ApplicationController
  before_action :find_employee, except: %i[index new skill_experience]
  before_action :load_data, only: %i[index show]

  def index
    redirect_to current_employee if current_employee.developer?
  end

  def show
    @employee.build_image unless @employee.image
    @project = @employee.projects.new
    @project.image = Image.new
  end

  def update
    authorize @employee
    @employee.additional = employee_params[:additional] || {}
    if @employee.update(employee_params)
      flash[:notice] = 'Successfully updated'
    else
      flash[:danger] = 'Is not updated'
    end
    redirect_to employee_path(@employee)
  end

  def destroy
    authorize @employee
    if @employee.delete
      flash[:notice] = 'Successfully deleted'
    else
      flash[:danger] = 'Is not deleted'
    end
    redirect_to employees_path
  end

  def skill_experience
    employee = Employee.friendly.find params[:employee_id]
    skill = employee.resource_skills.find params.dig(:skill_experience, :id)
    skill.update_attributes!(skill_experience_params)
    redirect_to employee
  end

  private

  def find_employee
    @employee = Employee.includes(:projects, :skills).friendly.find(params[:id])
  end

  def load_data
    @employees = Employee.preload(:skills).filter(params.reject { |_, v| v.blank? }.slice(:role, :office, :department))
    @employees = Employee.filter_skills(@employees, params[:skills]) if params[:skills]
    @employees = @employees.to_a.group_by(&:department) unless @employees.empty?
    @employees = Employee.search(params[:term]).to_a.group_by(&:department) if params[:term]

    @skills = Skill.all
  end

  def employee_params
    params.require(:employee).permit!
  end

  def skill_experience_params
    params.require(:skill_experience).permit!
  end

  def pundit_user
    current_employee
  end
end
