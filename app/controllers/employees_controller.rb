class EmployeesController < ApplicationController
  before_action :find_employee, only: %i[show edit update destroy]
  before_action :employees, only: %i[index show]
  before_action :skills, only: %i[index show]

  def index; end

  def show
    @employee.build_image unless @employee.image
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new employee_params
    if @employee.save
      flash[:notice] = 'Successfully created'
      redirect_to employee_path(@employee)
    else
      flash[:danger] = 'Is not created'
      render :new
    end
  end

  def edit; end

  def update
    if @employee.update(employee_params)
      flash[:notice] = 'Successfully updated'
      redirect_to employee_path(@employee)
    else
      flash[:danger] = 'Is not updated'
      render :edit
    end
  end

  def destroy
    if @employee.delete
      flash[:notice] = 'Successfully deleted'
    else
      flash[:danger] = 'Is not deleted'
    end
    redirect_to employees_path
  end

  private

  def find_employee
    @employee = Employee.includes(:projects, :skills).friendly.find(params[:id])
  end

  def skills
    @skills = Skill.all.to_a.group_by { |s| s.skill_type }
  end

  def employees
    @employees = Employee.all.to_a.group_by { |s| s.department }
  end

  def employee_params
    params.require(:employee).permit!
  end
end
