# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employees::DeleteService do
  let(:employee) { create(:employee) }
  let(:params) { { employee: employee } }

  subject { described_class.perform(params) }

  describe '#call' do
    it 'deletes employee' do
      expect(employee).to receive(:delete!)
      subject
    end

    context 'when `employee` is missing' do
      let(:employee) { nil }

      it { expect { subject }.to raise_error ArgumentError, '`employee` is missing' }
    end
  end
end
