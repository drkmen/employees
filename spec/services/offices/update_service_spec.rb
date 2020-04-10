# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Offices::UpdateService do
  let(:office) { create(:office) }
  let(:params) do
    {
      office: office,
      name: 'name'
    }
  end

  subject { described_class.perform(params) }

  describe '#call' do
    it 'updates office' do
      expect(office).to receive(:update_attributes!).with(params.except(:office))
      subject
    end

    context 'when `office` is missing' do
      let(:office) { nil }

      it { expect { subject }.to raise_error ArgumentError, '`office` is missing' }
    end
  end
end
