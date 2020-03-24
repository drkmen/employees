# frozen_string_literal: true

class OfficesController < ApplicationController
  before_action :find_office, only: %i[update destroy]

  def index
    authorize :office, :index?
    # redirect_to employee_path(current_employee) unless current_employee.admin? || current_employee.manager?

    @offices = Office.all.order(employees_count: :desc)
    @office = Office.new

    @departments = Department.all.order(employees_count: :desc)
    @department = Department.new
    load_data
  end

  def create
    authorize :office, :create?

    if Office.create(office_params)
      redirect_to offices_path
      flash[:success] = 'Successfully created'
    end
  end

  def update
    authorize @office

    if @office.update(office_params)
      redirect_to offices_path
      flash[:success] = 'Successfully update'
    end
  end

  def destroy
    authorize @office

    if @office.destroy
      redirect_to offices_path
      flash[:success] = 'Successfully deleted'
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