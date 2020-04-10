# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Offices::DestroyService do
  let(:office) { create(:office) }
  let(:params) { { office: office } }

  subject { described_class.perform(params) }

  describe '#call' do
    it 'deletes office' do
      expect(office).to receive(:destroy)
      subject
    end

    context 'when `office` is missing' do
      let(:office) { nil }

      it { expect { subject }.to raise_error ArgumentError, '`office` is missing' }
    end
  end
end
