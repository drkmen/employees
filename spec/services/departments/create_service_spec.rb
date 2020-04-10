# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Departments::CreateService do
  let(:params) do
    {
      name: 'name',
      team_lead_id: 1
    }
  end

  subject { described_class.perform(params) }

  describe '#call' do
    it 'creates department' do
      expect(Department).to receive(:create!).with(params)
    end

    after { subject }
  end
end
