# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DepartmentPolicy do
  Employee::ROLES.each do |role|
    let(role) { create(:employee, role: role) }
  end

  subject { described_class }

  permissions :create?, :update?, :destroy? do
    context 'grants access for' do
      it 'manager' do
        expect(subject).to permit(manager)
      end

      it 'admin' do
        expect(subject).to permit(admin)
      end
    end

    context 'denies access for' do
      it 'other' do
        expect(subject).to_not permit(other)
      end

      it 'developer' do
        expect(subject).to_not permit(developer)
      end

      it 'team_lead' do
        expect(subject).to_not permit(team_lead)
      end

      it 'system_administrator' do
        expect(subject).to_not permit(system_administrator)
      end
    end
  end
end
