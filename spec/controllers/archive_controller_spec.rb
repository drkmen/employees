# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArchiveController, type: :controller do

  context 'signed out user' do
    it 'should redirect to login' do
      get :index
      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_employee_session_path
    end
  end

  context 'signed in developer' do

    before do
      @developer = FactoryBot.create(:employee, :developer)
      sign_in @developer
    end

    describe 'GET #index' do
      it 'returns a success response' do
        get :index
        expect(response).to have_http_status(302)
        expect(response).to redirect_to employee_path(@developer)
      end
    end
  end

  context 'signed in admin' do
    before do
      FactoryBot.create(:employee, :deleted)
      user = FactoryBot.create(:employee, :admin)
      sign_in user
    end

    describe 'GET #index' do
      it 'returns a success response' do
        get :index
        expect(response.status).to eq(200)
        expect(response).to render_template('index')
        expect(assigns(:employees).size).to be 1
      end
    end

    describe 'GET #destroy' do
      it 'returns a success response' do
        expect do
          post :destroy, params: { id: Employee.deleted.last }
        end.to(change { Employee.deleted.count }.by(-1)) &&
          have_http_status(302) &&
          render_template('index')
      end
    end
  end
end
