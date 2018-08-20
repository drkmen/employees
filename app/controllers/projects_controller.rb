# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :find_project, only: %i[update destroy]

  def create
    @project = Project.new(project_params)
    authorize @project
    if @project.save
      flash[:notice] = 'Successfully created'
    else
      flash[:danger] = 'Is not created'
    end
    redirect_to employee_path(project_params[:employee_id])
  end

  def update
    authorize @project
    if @project.update(project_params)
      flash[:notice] = 'Successfully updated'
    else
      flash[:danger] = 'Is not updated'
    end
    redirect_to employee_path(project_params[:employee_id])
  end

  def destroy
    authorize @project
    if @project.destroy
      flash[:notice] = 'Successfully destroyed'
    else
      flash[:danger] = 'Is not destroyed'
    end
    redirect_to employee_path(params[:employee_id])
  end

  private

  def project_params
    params.require(:project).permit(:employee_id, :name, :description,
                                    :client, :link, :repository, :active,
                                    :manager_id, :start_date, :end_date,
                                    image_attributes: {}, skill_ids: [])
  end

  def find_project
    @project = Project.find(params[:id])
  end

  def pundit_user
    current_employee
  end
end
