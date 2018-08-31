# frozen_string_literal: true

class SkillsController < ApplicationController
  before_action :find_skill, only: %i[update destroy]

  def index
    @skills = Skill.all
    @skill = Skill.new

    load_data
  end

  def show
    @skill = Skill.find(params[:id])
    respond_to do |format|
      format.js do
        @employee = Employee.find(params[:employee_id]) if params[:employee_id]
        if @skill.present?
          render status: :found
        else
          render status: :not_found
        end
      end
    end
  end

  def update
    authorize @skill
    if @skill.update skill_params
      flash[:notice] = 'Successfully updated'
    else
      flash[:danger] = 'Is not updated'
    end
    redirect_to skills_path
  end

  def create
    @skill = Skill.new(skill_params)
    authorize @skill
    if @skill.save
      flash[:notice] = 'Successfully created'
    else
      flash[:danger] = 'Is not created [duplicate]'
    end
    redirect_to skills_path
  end

  def destroy
    authorize @skill
    if @skill.destroy
      flash[:notice] = 'Successfully destroyed'
    else
      flash[:danger] = 'Is not destroyed'
    end
    redirect_to skills_path
  end

  private

  def find_skill
    @skill = Skill.find(params[:id])
  end

  def skill_params
    params.require(:skill).permit(:name, :skill_type, :employee_id)
  end

  def pundit_user
    current_employee
  end
end
