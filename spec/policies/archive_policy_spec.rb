# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArchivePolicy do
  let(:manager) { create(:employee, :manager) }
  let(:admin) { create(:employee, :admin) }

  subject { described_class }

  permissions :index? do
    context 'grants access for' do
      it 'manager' do
        expect(subject).to permit(manager)
      end

      it 'admin' do
        expect(subject).to permit(admin)
      end
    end
  end
end
