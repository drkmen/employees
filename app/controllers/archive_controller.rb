class ArchiveController < ApplicationController

  def index
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
