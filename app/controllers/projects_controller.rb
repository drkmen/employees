# frozen_string_literal: true

class ProjectsController < ApplicationController

  def create
    if Project.create project_params
      flash[:notice] = 'Successfully created'
    else
      flash[:danger] = 'Is not created'
    end
    redirect_to employee_path(project_params[:employee_id])
  end

  def update
    if Project.find(params[:id]).update(project_params)
      flash[:notice] = 'Successfully updated'
    else
      flash[:danger] = 'Is not updated'
    end
    redirect_to employee_path(project_params[:employee_id])
  end

  def destroy
    if Project.find(params[:id]).destroy
      flash[:notice] = 'Successfully destroyed'
    else
      flash[:danger] = 'Is not destroyed'
    end
    redirect_to employee_path(params[:employee_id])
  end

  private

  def project_params
    params.require(:project).permit!
  end
end
