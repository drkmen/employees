# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Archives::RestoreEmployeesService do
  let(:employee) { create(:employee, :deleted) }
  let(:params) { { employee: employee } }

  subject { described_class.perform(params) }

  describe '#call' do
    it 'restores employee' do
      expect(employee).to receive(:restore!)
      subject
    end

    context 'when employee is missing' do
      let(:employee) { nil }

      it 'raises an error' do
        expect { subject }.to raise_error ArgumentError, 'Employee not found' unless employee
      end
    end
  end
end
