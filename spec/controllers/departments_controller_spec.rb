# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do
  Employee::ROLES.each do |role|
    let(role) { create(:employee, role: role) }
  end

  let(:department) { create(:department) }
  let(:name) { Faker::Name.name }
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

    it_behaves_like 'authorizable' do
      let(:target) { [:department, :create?] }
    end

    context 'when user' do
      context 'is not authenticated' do
        before { send_request }

        it_behaves_like 'unauthenticated'
      end

      context 'authenticated as' do
        before { sign_in user }

        common_roles.each do |role|
          context role do
            let(:user) { public_send(role) }

            it_behaves_like 'unauthorized'
          end
        end

        adminable_roles.each do |role|
          context role do
            let(:user) { public_send(role) }
            let(:service_params) { strong_params.require(:department).permit(:name, :team_lead_id) }

            before { |example| send_request unless example.metadata[:skip_before] }

            it 'calls Departments::CreateService', :skip_before do
              expect(Departments::CreateService).to receive(:perform).with(service_params)
              send_request
            end

            it_behaves_like 'success response' do
              let(:path) { offices_path }
              let(:message) { 'Successfully created' }
            end
          end
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

    it_behaves_like 'authorizable' do
      let(:target) { department }
    end

    context 'when user' do
      context 'is not authenticated' do
        before { send_request }

        it_behaves_like 'unauthenticated'
      end

      context 'authenticated as' do
        before { sign_in user }

        common_roles.each do |role|
          context role do
            let(:user) { public_send(role) }

            it_behaves_like 'unauthorized'
          end
        end

        adminable_roles.each do |role|
          context role do
            let(:user) { public_send(role) }
            let(:service_params) { strong_params.require(:department).permit(:name, :team_lead_id) }

            before { |example| send_request unless example.metadata[:skip_before] }

            it 'calls Departments::UpdateService', :skip_before do
              expect(Departments::UpdateService).to receive(:perform).with(department: department,
                                                                           department_params: service_params)
              send_request
            end

            it_behaves_like 'success response' do
              let(:path) { offices_path }
              let(:message) { 'Successfully updated' }
            end
          end
        end
      end
    end
  end

  describe 'DELETE#destroy' do
    let(:send_request) { delete :destroy, params: request_params }
    let(:request_params) { { id: department.id } }

    it_behaves_like 'authorizable' do
      let(:target) { department }
    end

    context 'when user' do
      context 'is not authenticated' do
        before { send_request }

        it_behaves_like 'unauthenticated'
      end

      context 'authenticated as' do
        before { sign_in user }

        common_roles.each do |role|
          context 'developer' do
            let(:user) { public_send(role) }

            it_behaves_like 'unauthorized'
          end
        end

        adminable_roles.each do |role|
          context 'admin' do
            let(:user) { public_send(role) }

            before { |example| send_request unless example.metadata[:skip_before] }

            it 'calls Departments::UpdateService', :skip_before do
              expect(Departments::DestroyService).to receive(:perform).with(department: department)
              send_request
            end

            it_behaves_like 'success response' do
              let(:path) { offices_path }
              let(:message) { 'Successfully deleted' }
            end
          end
        end
      end
    end
  end
end
