# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Departments::DestroyService do
  let(:department) { create(:department) }
  let(:params) { { department: department } }

  subject { described_class.perform(params) }

  describe '#call' do
    it 'deletes department' do
      expect(department).to receive(:destroy)
      subject
    end

    context 'when `department` is missing' do
      let(:department) { nil }

      it { expect { subject }.to raise_error ArgumentError, '`department` is missing' }
    end
  end
end
