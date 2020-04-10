# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OfficesController, type: :controller do
  Employee::ROLES.each do |role|
    let(role) { create(:employee, role: role) }
  end

  let(:office) { create(:office) }
  let(:name) { Faker::Name.name }
  let(:strong_params) { ActionController::Parameters.new(request_params) }

  describe 'POST#create' do
    let(:send_request) { post :create, params: request_params }
    let(:request_params) do
      {
        office: {
          name: name
        }
      }
    end

    it_behaves_like 'authorizable' do
      let(:target) { [:office, :create?] }
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
            let(:service_params) { strong_params.require(:office).permit(:name) }

            before { |example| send_request unless example.metadata[:skip_before] }

            it 'calls Offices::CreateService', :skip_before do
              expect(Offices::CreateService).to receive(:perform).with(service_params)
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

  describe 'PUT#update' do
    let(:send_request) { put :update, params: request_params }
    let(:request_params) do
      {
        id: office.id,
        office: {
          name: name
        }
      }
    end

    it_behaves_like 'authorizable' do
      let(:target) { office }
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
            let(:service_params) { strong_params.require(:office).permit(:name) }

            before { |example| send_request unless example.metadata[:skip_before] }

            it 'calls Offices::UpdateService', :skip_before do
              expect(Offices::UpdateService).to receive(:perform).with(service_params.merge(office: office))
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
    let(:request_params) do
      {
        id: office.id,
      }
    end

    it_behaves_like 'authorizable' do
      let(:target) { office }
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
            let(:service_params) { { office: office } }

            before { |example| send_request unless example.metadata[:skip_before] }

            it 'calls Offices::UpdateService', :skip_before do
              expect(Offices::DestroyService).to receive(:perform).with(office: office)
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
