# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArchiveController, type: :controller do
  let(:developer) { create(:employee, :developer) }
  let(:admin) { create(:employee, :admin) }
  let!(:deleted_employee) { create(:employee, :deleted) }

  describe 'GET#index' do
    let(:send_request) { get :index }

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

          before { send_request }

          it { expect(response.status).to eq(200) }
          it { expect(response).to render_template('index') }
        end
      end
    end
  end

  describe 'PATCH#restore' do
    let(:send_request) { patch :restore, params: { employee_id: deleted_employee.id } }

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

          it 'restores employee' do
            expect do
              send_request
            end.to(change { Employee.deleted.count }.by(-1)) &&
              have_http_status(302) &&
              render_template('index')
          end
        end
      end
    end
  end

  describe 'DELETE#destroy' do
    let(:send_request) { delete :destroy, params: { employee_id: deleted_employee.id } }

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

          it 'deletes employee' do
            expect do
              send_request
            end.to(change { Employee.deleted.count }.by(-1)) &&
                have_http_status(302) &&
                render_template('index')
          end
        end
      end
    end
  end
end
