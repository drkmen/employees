class OfficesController < ApplicationController
  before_action :find_office, only: %i[update destroy]

  def index
    redirect_to employee_path(current_employee) unless current_employee.admin? || current_employee.manager?
    @offices = Office.all.order(employees_count: :desc)
    @office = Office.new

    @departments = Department.all.order(employees_count: :desc)
    @department = Department.new
    load_data
  end

  def create
    if Office.create(office_params)
      redirect_to offices_path
      flash[:notice] = 'Successfully created'
    end
  end

  def update
    if @office.update(office_params)
      redirect_to offices_path
      flash[:notice] = 'Successfully update'
    end
  end

  def destroy
    if @office.destroy
      redirect_to offices_path
      flash[:notice] = 'Successfully deleted'
    end
  end

  private

  def find_office
    @office = Office.find(params[:id])
  end

  def office_params
    params.require(:office).permit(:name)
  end
end