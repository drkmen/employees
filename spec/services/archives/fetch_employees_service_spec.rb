# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Archives::FetchEmployeesService do
  let!(:employee) { create(:employee, :deleted) }
  let!(:employee_1) { create(:employee, :deleted, deleted_at: Date.today - 1.month) }
  let!(:employee_2) { create(:employee, :deleted, deleted_at: Date.today - 1.year) }
  let(:params) { { current_employee: current_employee } }

  subject { described_class.perform(params) }

  describe '#call' do
    let(:current_employee) { nil }
    let(:expected_result) do
      {
        employee.deleted_at.year => {
          employee.deleted_at.month => [employee],
          employee_1.deleted_at.month => [employee_1]
        },
        employee_2.deleted_at.year => {
          employee_2.deleted_at.month => [employee_2]
        }
      }
    end

    it { is_expected.to contain_exactly(*expected_result) }

    context 'when current_employee provided' do
      context 'and current_employee is team_lead' do
        let(:current_employee) { create(:employee, :team_lead, grant_admin_permissions: permission) }

        context 'and have admin permission' do
          let(:permission) { true }

          it { is_expected.to contain_exactly(*expected_result) }
        end

        context 'and do not have admin permission' do
          let(:permission) { false }
          let!(:employee_3) { create(:employee, :deleted,
                                           deleted_at: Date.today - 1.year,
                                           department: current_employee.department) }
          let(:expected_result) do
            {
              employee_3.deleted_at.year => {
                employee_3.deleted_at.month => [employee_3]
              }
            }
          end

          it { is_expected.to contain_exactly(*expected_result) }
        end
      end
    end
  end
end
