# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  before do
    FactoryBot.create(:employee, :admin_full)
    FactoryBot.create(:project, employee_id: Employee.last.id)
  end

  describe 'POST #create' do
    it 'returns a success response' do
      expect do
        post :create, params: { project: { name: 'qweqwe', employee_id: Employee.last.id } }
      end.to(change { Project.count }.by(1)) &&
        redirect_to(Employee.last &&
        have_http_status(302)) &&
        render_template('show') &&
        eq(Employee.last)
    end

    it 'returns a fail response and render #new' do
      expect do
        post :create, params: { project: { name: nil, employee_id: Employee.last.id } }
      end.to(change { Project.count }.by(0)) &&
        redirect_to(Employee.last &&
        have_http_status(302)) &&
        render_template('show') &&
        eq(Employee.last)
    end
  end

  describe 'PATCH #update' do
    it 'returns a success response' do
      patch :update, params: { id: Project.last.id, project: { employee_id: Employee.last.id, name: 'qweqwe', description: 'qweqwe' } }
      expect(response.status).to eq(302)
      expect(redirect_to(Employee.last)).to be_truthy
      expect(Project.last.name).to eq('qweqwe')
    end
  end

  describe 'GET #destroy' do
    it 'returns a success response' do
      expect do
        post :destroy, params: { id: Project.last.id, employee_id: Employee.last.id }
      end.to(change { Project.count }.by(-1)) &&
        redirect_to(Employee.last &&
        have_http_status(302)) &&
        render_template('show') &&
        eq(Employee.last)
    end
  end
end
