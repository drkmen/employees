# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Offices::CreateService do
  let(:params) { { name: 'name' } }

  subject { described_class.perform(params) }

  describe '#call' do
    it 'creates office' do
      expect(Office).to receive(:create!).with(params)
    end

    after { subject }
  end
end
