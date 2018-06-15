# frozen_string_literal: true

# Skills Controller

class SkillsController < ApplicationController
  before_action :find_skill, only: %i[update destroy]

  def index
    @skills = Skill.all
    @skill = Skill.new

    @employees = Employee.preload(:skills, :resource_skills).filter(params.reject { |_, v| v.blank? }.slice(:role, :office, :department))
    @employees = Employee.filter_skills(@employees, params[:skills]) if params[:skills]
    @employees = @employees.to_a.group_by(&:department) unless @employees.empty?
    @employees = Employee.search(params[:term]).to_a.group_by(&:department) if params[:term]
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
    params.require(:skill).permit!
  end

  def pundit_user
    current_employee
  end
end
