# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :find_project, only: %i[edit update destroy]

  def new
    @project = Project.new
    @project.skills.new
    @project.image = Image.new
    @skills = Skill.all
  end

  def create
    @project = current_employee.projects.new project_params
    if @project.save!
      flash[:notice] = 'Successfully created'
    else
      flash[:danger] = 'Is not created'
    end
    redirect_to new_project_path
  end

  def edit; end

  def update
    if @project.update(project_params)
      flash[:notice] = 'Successfully updated'
      redirect_to project_path(@project)
    else
      flash[:danger] = 'Is not updated'
      render :edit
    end
  end

  def destroy
    if @project.destroy
      flash[:notice] = 'Successfully destroyed'
    else
      flash[:danger] = 'Is not destroyed'
    end
    redirect_to projects_path
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit!
  end
end
