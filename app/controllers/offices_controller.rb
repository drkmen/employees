# frozen_string_literal: true

class OfficesController < ApplicationController
  before_action :find_office, only: %i[update destroy]

  def index
    authorize :office, :index?

    @offices = Office.all.order(employees_count: :desc)
    @office = Office.new

    @departments = Department.all.order(employees_count: :desc)
    @department = Department.new
    load_data
  end

  def create
    authorize :office, :create?

    Offices::CreateService.perform(office_params)
    flash[:success] = 'Successfully created'
    redirect_to offices_path
  end

  def update
    authorize @office

    Offices::UpdateService.perform(office_params.merge(office: @office))
    flash[:success] = 'Successfully updated'
    redirect_to offices_path
  end

  def destroy
    authorize @office

    Offices::DestroyService.perform(office: @office)
    flash[:success] = 'Successfully deleted'
    redirect_to offices_path
  end

  private

  def find_office
    @office = Office.find(params[:id])
  end

  def office_params
    params.require(:office).permit(:name)
  end
end
