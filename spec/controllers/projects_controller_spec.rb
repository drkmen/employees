require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  before do
    FactoryBot.create(:employee, :admin_full)
    FactoryBot.create(:project, employee_id: Employee.last.id)
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response.status).to eq(200)
      expect(response).to render_template('new')
      expect(assigns(:project).name).to eq(nil)
    end
  end

  describe 'POST #create' do
    it 'returns a success response' do
      expect do
        post :create, params: { project: FactoryBot.attributes_for(:project, employee_id: Employee.last.id)}
      end.to(change { Project.count }.by(1)) &&
          redirect_to(Project.last &&
          have_http_status(302)) &&
          render_template('show') &&
          eq(Project.last)
    end

    it 'returns a fail response and render #new' do
      expect do
        post :create, params: { project: FactoryBot.attributes_for(:invalid_project, employee_id: Employee.last.id) }
      end.to(change { Project.count }.by(0)) &&
          redirect_to(Project.last &&
          have_http_status(200)) &&
          render_template('new')
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: Project.last.to_param }
      expect(response.status).to eq(200)
      expect(response).to render_template('edit')
      expect(assigns(:project)).to eq(Project.last)
    end
  end

  describe 'PUT #update' do
    it 'returns a success response' do
      put :update, params: {
          id: Project.last.id, project: { name: 'qweqwe', description: 'qweqwe' }
      }
      expect(response.status).to eq(302)
      expect(redirect_to(Project.last)).to be_truthy
      expect(assigns(:project)).to eq(Project.last)
      expect(Project.last.name).to eq('qweqwe')
    end
  end

  describe 'GET #destroy' do
    it 'returns a success response' do
      expect do
        post :destroy, params: { id: Project.last.id }
      end.to(change { Project.count }.by(-1)) &&
          have_http_status(302) &&
          render_template('index')
    end
  end
end
