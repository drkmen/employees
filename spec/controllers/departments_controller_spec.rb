# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do
  let(:developer) { create(:employee, :developer) }
  let(:admin) { create(:employee, :admin) }
  let(:department) { create(:department) }
  let(:strong_params) { ActionController::Parameters.new(request_params) }

  describe 'POST#create' do
    let(:send_request) { post :create, params: request_params }
    let(:request_params) do
      {
        department: {
          name: name,
          team_lead_id: developer.id.to_s
        }
      }
    end
    let(:name) { Faker::Name.name }

    it 'check permissions' do
      sign_in admin
      expect(controller).to receive(:authorize).with(:department, :create?).and_call_original
      send_request
    end

    context 'when user' do
      context 'is not authenticated' do
        before { send_request }

        it_behaves_like 'unauthenticated'
      end

      context 'authenticated as' do
        before { sign_in user }

        context 'developer' do
          let(:user) { developer }

          it_behaves_like 'unauthorized'
        end

        context 'admin' do
          let(:user) { admin }
          let(:service_params) { strong_params.require(:department).permit(:name, :team_lead_id) }

          before { |example| send_request unless example.metadata[:skip_before] }

          it 'calls Departments::CreateService', :skip_before do
            expect(Departments::CreateService).to receive(:perform).with(service_params)
            send_request
          end

          it { expect(flash[:success]).to eq 'Successfully created' }
          it { expect(response).to have_http_status(302) }
          it { expect(response).to redirect_to(offices_path) }
        end
      end
    end
  end

  describe 'PATCH#update' do
    let(:send_request) { patch :update, params: request_params }
    let(:request_params) do
      {
        id: department.id,
        department: {
          name: name,
          team_lead_id: developer.id.to_s
        }
      }
    end
    let(:name) { Faker::Name.name }

    it 'check permissions' do
      sign_in admin
      expect(controller).to receive(:authorize).with(department).and_call_original
      send_request
    end

    context 'when user' do
      context 'is not authenticated' do
        before { send_request }

        it_behaves_like 'unauthenticated'
      end

      context 'authenticated as' do
        before { sign_in user }

        context 'developer' do
          let(:user) { developer }

          it_behaves_like 'unauthorized'
        end

        context 'admin' do
          let(:user) { admin }
          let(:service_params) { strong_params.require(:department).permit(:name, :team_lead_id) }

          before { |example| send_request unless example.metadata[:skip_before] }

          it 'calls Departments::UpdateService', :skip_before do
            expect(Departments::UpdateService).to receive(:perform).with(service_params.merge(department: department))
            send_request
          end

          it { expect(flash[:success]).to eq 'Successfully updated' }
          it { expect(response).to have_http_status(302) }
          it { expect(response).to redirect_to(offices_path) }
        end
      end
    end
  end

  describe 'DELETE#destroy' do
    let(:send_request) { delete :destroy, params: request_params }
    let(:request_params) { { id: department.id } }

    it 'check permissions' do
      sign_in admin
      expect(controller).to receive(:authorize).with(department).and_call_original
      send_request
    end

    context 'when user' do
      context 'is not authenticated' do
        before { send_request }

        it_behaves_like 'unauthenticated'
      end

      context 'authenticated as' do
        before { sign_in user }

        context 'developer' do
          let(:user) { developer }

          it_behaves_like 'unauthorized'
        end

        context 'admin' do
          let(:user) { admin }

          before { |example| send_request unless example.metadata[:skip_before] }

          it 'calls Departments::UpdateService', :skip_before do
            expect(Departments::DestroyService).to receive(:perform).with(department: department)
            send_request
          end

          it { expect(flash[:success]).to eq 'Successfully deleted' }
          it { expect(response).to have_http_status(302) }
          it { expect(response).to redirect_to(offices_path) }
        end
      end
    end
  end
end
