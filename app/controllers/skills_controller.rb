# frozen_string_literal: true

# Skills Controller
class SkillsController < ApplicationController
  before_action :find_skill, except: %i[new create]

  def edit; end

  def update
    if @skill.update skill_params
      flash[:notice] = 'Successfully updated'
      redirect_to root_path
    else
      flash[:danger] = 'Is not updated'
      render :edit
    end
  end

  def new
    @skill = Skill.new
  end

  def create
    if Skill.create(skill_params)
      flash[:notice] = 'Successfully created'
      redirect_to root_path
    else
      flash[:danger] = 'Is not created'
      render :new
    end
  end

  def destroy
    if @skill.destroy
      flash[:notice] = 'Successfully destroyed'
    else
      flash[:danger] = 'Is not destroyed'
    end
    redirect_to root_path
  end

  private

  def find_skill
    @skill = Skill.find(params[:id])
  end

  def skill_params
    params.require(:skill).permit!
  end
end
