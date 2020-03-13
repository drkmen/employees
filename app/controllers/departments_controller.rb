class DepartmentsController < ApplicationController
  before_action :find_department, only: %i[update destroy]

  def create
    department = Department.new department_params
    if department.save
      redirect_to offices_path
      flash[:success] = 'Successfully created'
    else
      redirect_to offices_path
      flash[:danger] = department.errors.messages
    end
  end

  def update
    if @department.update(department_params)
      redirect_to offices_path
      flash[:success] = 'Successfully update'
    end
  end

  def destroy
    if @department.destroy
      redirect_to offices_path
      flash[:success] = 'Successfully deleted'
    end
  end

  private

  def find_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name, :team_lead_id)
  end
end