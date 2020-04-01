# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArchiveController, type: :controller do
  Employee::ROLES.each do |role|
    let(role) { create(:employee, role: role) }
  end

  let!(:deleted_employee) { create(:employee, :deleted, department: team_lead.department) }

  describe 'GET#index' do
    let(:send_request) { get :index }

    it_behaves_like 'authorizable' do
      let(:target) { [:archive, :index?] }
    end

    context 'when user' do
      context 'is not authenticated' do
        before { send_request }

        it_behaves_like 'unauthenticated'
      end

      context 'authenticated as' do
        before { sign_in user }

        common_roles.without('team_lead').each do |role|
          context role do
            let(:user) { public_send(role) }

            it_behaves_like 'unauthorized'
          end
        end

        (adminable_roles + ['team_lead']).each do |role|
          context role do
            let(:user) { public_send(role) }

            before { |example| send_request unless example.metadata[:skip_before] }

            it 'calls Archives::FetchEmployeesService', :skip_before do
              expect(Archives::FetchEmployeesService).to receive(:perform).with(current_employee: user)
              send_request
            end

            it { expect(response.status).to eq(200) }
            it { expect(response).to render_template('index') }
          end
        end
      end
    end
  end

  describe 'PATCH#restore' do
    let(:send_request) { patch :restore, params: { employee_id: deleted_employee.id } }

    it_behaves_like 'authorizable' do
      let(:target) { deleted_employee }
    end

    context 'when user' do
      context 'is not authenticated' do
        before { send_request }

        it_behaves_like 'unauthenticated'
      end

      context 'authenticated as' do
        before { sign_in user }

        common_roles.without('team_lead').each do |role|
          context role do
            let(:user) { public_send(role) }

            it_behaves_like 'unauthorized'
          end
        end

        (adminable_roles + ['team_lead']).each do |role|
          context role do
            let(:user) { public_send(role) }

            before { |example| send_request unless example.metadata[:skip_before] }

            it 'restores employee', :skip_before do
              expect(Archives::RestoreEmployeesService).to receive(:perform).with(employee: deleted_employee)
              send_request
            end

            it_behaves_like 'success response' do
              let(:path) { archive_index_path }
              let(:message) { 'Successfully restored' }
            end
          end
        end
      end
    end
  end

  describe 'DELETE#destroy' do
    let(:send_request) { delete :destroy, params: { employee_id: deleted_employee.id } }

    it_behaves_like 'authorizable' do
      let(:target) { [:archive, :destroy?] }
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

            before { |example| send_request unless example.metadata[:skip_before] }

            it 'deletes employee', :skip_before do
              expect(Archives::DeleteEmployeesService).to receive(:perform).with(employee: deleted_employee)
              send_request
            end

            it_behaves_like 'success response' do
              let(:path) { archive_index_path }
              let(:message) { 'Successfully deleted' }
            end
          end
        end
      end
    end
  end
end
