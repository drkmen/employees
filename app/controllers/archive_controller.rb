# frozen_string_literal: true

class ArchiveController < ApplicationController
  before_action :find_employee, only: %i[restore destroy]

  def index
    authorize :archive, :index?
    @grouped_employees = Archives::FetchEmployeesService.perform
  end

  def restore
    authorize @employee
    if @employee.restore!
      flash[:success] = 'Successful restored'
    else
      flash[:danger] = 'Not restored'
    end
    redirect_to archive_index_path
  end

  def destroy
    authorize @employee
    if @employee.destroy!
      flash[:success] = 'Successful deleted'
    else
      flash[:danger] = 'Not deleted'
    end
    redirect_to archive_index_path
  end

  private

  def find_employee
    @employee = Employee.deleted.friendly.find(params[:employee_id])
  end
end
