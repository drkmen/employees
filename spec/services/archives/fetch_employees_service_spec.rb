# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Archives::FetchEmployeesService do
  let!(:employee) { create(:employee, :deleted) }
  let!(:employee_1) { create(:employee, :deleted, deleted_at: Date.today - 1.month) }
  let!(:employee_2) { create(:employee, :deleted, deleted_at: Date.today - 1.year) }

  subject { described_class.perform }

  describe '#call' do
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

    it { is_expected.to eq expected_result }
  end
end
