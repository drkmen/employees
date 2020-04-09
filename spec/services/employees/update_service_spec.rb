# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employees::UpdateService do
  let(:employee) { create(:employee) }
  let(:params) do
    {
      employee: employee,
      employee_params: {
        first_name: 'name'
      }
    }
  end

  subject { described_class.perform(params) }

  describe '#call' do
    it 'updates employee' do
      expect(employee).to receive(:update_attributes!).with(params[:employee_params])
      subject
    end

    context 'when `employee` is missing' do
      let(:employee) { nil }

      it { expect { subject }.to raise_error ArgumentError, '`employee` is missing' }
    end
  end
end
