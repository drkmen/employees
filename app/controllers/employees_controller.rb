class EmployeesController < ApplicationController
  before_action :find_employee, only: %i[show edit update destroy]

  def index
    @employees = Employee.all
  end

  def show; end

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
    if @employee.destroy
      flash[:notice] = 'Successfully destroyed'
    else
      flash[:danger] = 'Is not destroyed'
    end
    redirect_to employees_path
  end

  private

  def find_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit!
  end
end