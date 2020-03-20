class DepartmentsController < ApplicationController
  before_action :find_department, only: %i[update destroy]

  def create
    authorize :department, :create?

    Departments::CreateService.perform(department_params)
    flash[:success] = 'Successfully created'
    redirect_to offices_path
  end

  def update
    authorize @department

    Departments::UpdateService.perform(department_params.merge(department: @department))
    flash[:success] = 'Successfully updated'
    redirect_to offices_path
  end

  def destroy
    authorize @department

    Departments::DestroyService.perform(department: @department)
    flash[:success] = 'Successfully deleted'
    redirect_to offices_path
  end

  private

  def find_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name, :team_lead_id)
  end
end