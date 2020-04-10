# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Departments::UpdateService do
  let(:team_lead) { create(:employee, :team_lead) }
  let(:department) { create(:department) }
  let(:params) do
    {
      department: department,
      department_params: {
        name: 'name',
        team_lead_id: team_lead.id
      }
    }
  end

  subject { described_class.perform(params) }

  describe '#call' do
    it 'updates department' do
      expect(department).to receive(:update_attributes!).with(params[:department_params])
      subject
    end

    context 'when `department` is missing' do
      let(:department) { nil }

      it { expect { subject }.to raise_error ArgumentError, '`department` is missing' }
    end
  end
end
