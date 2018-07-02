# frozen_string_literal: true

class ArchiveController < ApplicationController
  def index
    redirect_to current_employee if current_employee.developer?
    @employees = Employee.deleted
  end

  def destroy
    if Employee.deleted.friendly.find(params[:id]).restore
      flash[:success] = 'Successful restored'
    else
      flash[:danger] = 'Not restored'
    end
    redirect_to archive_index_path
  end
end
