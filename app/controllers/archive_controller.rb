# frozen_string_literal: true

class ArchiveController < ApplicationController
  before_action :find_employee, only: %i[restore destroy]

  def index
    authorize :archive, :index?

    @grouped_employees = Archives::FetchEmployeesService.perform(current_employee: current_user)
  end

  def restore
    authorize @employee

    Archives::RestoreEmployeesService.perform(employee: @employee)
    flash[:success] = 'Successfully restored'
    redirect_to archive_index_path
  end

  def destroy
    authorize :archive, :destroy?

    Employees::DestroyService.perform(employee: @employee)
    flash[:success] = 'Successfully deleted'
    redirect_to archive_index_path
  end

  private

  def find_employee
    @employee = Employee.deleted.friendly.find(params[:employee_id])
  end
end
