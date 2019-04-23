# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :find_employee, except: %i[index skill_experience]
  before_action :load_data, only: %i[index show]

  def index
    redirect_to current_employee if current_employee.developer_without_ap?
  end

  def show
    redirect_to current_employee if current_employee != @employee && current_employee.developer_without_ap?
    @employee.build_image unless @employee.image
    @project = @employee.projects.new
    @project.build_image

    respond_to do |format|
      format.html
      format.json if current_employee == @employee
      format.js
      format.pdf do
        render pdf: "#{@employee.slug}",
               template: 'employees/show_pdf.html.haml',
               locals: { keys: params.permit(params.keys).to_h },
               layout: 'pdf.html.haml',
               encoding: 'UTF-8',
               show_as_html: params.key?('debug'),
               margin: { top: 15, bottom: 15, left: 20, right: 20 }
      end
    end
  end

  def update
    authorize @employee
    @employee.additional = employee_params[:additional] || {}
    if @employee.update(employee_params)
      flash[:notice] = 'Successfully updated'
    else
      flash[:danger] = "Is not updated: #{@employee.errors.messages}"
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
    employee = Employee.includes(:skills).friendly.find(params[:employee_id])
    skill = employee.resource_skills.find params.dig(:skill_experience, :id)
    skill.update_attributes!(skill_experience_params)
    redirect_to employee
  end

  private

  def find_employee
    @employee = Employee.includes(projects: [:skills, :image, :manager, :developer]).friendly.find(params[:id])
    # additional query needed to avoid huge N+1
    @employee_skills = ResourceSkill.includes(skill: :employee).where(employee_id: @employee.id)
  end

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :main_skill, :description, :email, :password,
                                     :phone, :office, :role, :skype, :department, :upwork, :status, :office_id,
                                     additional: {}, image_attributes: {}, skill_ids: [],
                                     manager_ids: [], developer_ids: [])
  end

  def skill_experience_params
    params.require(:skill_experience).permit(:id, :experience, :level)
  end

  def pundit_user
    current_employee
  end
end
