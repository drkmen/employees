require 'rails_helper'

RSpec.describe ArchiveController, type: :controller do

  before do
    FactoryBot.create(:employee, :deleted)
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
