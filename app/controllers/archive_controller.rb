# frozen_string_literal: true

class ArchiveController < ApplicationController
  before_action :find_employee, only: %i[restore destroy]

  def index
    authorize :archive, :index?

    @grouped_employees = Archives::FetchEmployeesService.perform
  end

  def restore
    authorize @employee

    Archives::RestoreEmployeesService.perform(employee: @employee)
    flash[:success] = 'Successful restored'
    redirect_to archive_index_path
  end

  def destroy
    authorize @employee

    Archives::DeleteEmployeesService.perform(employee: @employee)
    flash[:success] = 'Successful deleted'
    redirect_to archive_index_path
  end

  private

  def find_employee
    @employee = Employee.deleted.friendly.find(params[:employee_id])
  end
end
