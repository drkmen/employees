# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  before do
    FactoryBot.create(:employee, :admin_full)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response.status).to eq(200)
      expect(response).to render_template('index')
      expect(assigns(:employees).size).to be 1
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: Employee.last.to_param }
      expect(response.status).to eq(200)
      expect(response).to render_template('show')
      expect(assigns(:employee)).to eq(Employee.last)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response.status).to eq(200)
      expect(response).to render_template('new')
      expect(assigns(:employee).first_name).to eq(nil)
    end
  end

  describe 'POST #create' do
    it 'returns a success response' do
      expect do
        post :create, params: {
            employee: { first_name: 'qwe-qwe', last_name: 'qwe-qwe', email: 'email@example.com', role: 1, password: '123123' }
        }
      end.to(change { Employee.count }.by(1)) &&
          redirect_to(Employee.last &&
                          have_http_status(302)) &&
          render_template('show') &&
          eq(Employee.last)
    end

    it 'returns a fail response and render #new' do
      expect do
        post :create, params: {
            employee: { first_name: 'qwe-qwe', last_name: 'qwe-qwe', email: 'email@example.com' }
        }
      end.to(change { Employee.count }.by(0)) &&
          redirect_to(Employee.last &&
                          have_http_status(200)) &&
          render_template('new')
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: Employee.last.to_param }
      expect(response.status).to eq(200)
      expect(response).to render_template('edit')
      expect(assigns(:employee)).to eq(Employee.last)
    end
  end

  describe 'PUT #update' do
    it 'returns a success response' do
      put :update, params: {
          id: Employee.last.id, employee: { first_name: 'qweqwe', last_name: 'qweqwe' }
      }
      expect(response.status).to eq(302)
      expect(redirect_to(Employee.last)).to be_truthy
      expect(assigns(:employee)).to eq(Employee.last)
      expect(Employee.last.first_name).to eq('qweqwe')
      expect(Employee.last.last_name).to eq('qweqwe')
    end
  end

  describe 'GET #destroy' do
    it 'returns a success response' do
      expect do
        post :destroy, params: { id: Employee.last.id }
      end.to(change { Employee.count }.by(-1)) &&
          have_http_status(302) &&
          render_template('index')
    end
  end
end