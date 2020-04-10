# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArchivePolicy do
  Employee::ROLES.each do |role|
    let(role) { FactoryBot.create(:employee, role.to_sym) }
  end

  subject { described_class }

  permissions :index?, :restore? do
    context 'grants access for' do
      (adminable_roles + ['team_lead']).each do |role|
        it role do
          expect(subject).to permit(public_send(role))
        end
      end
    end

    context 'denies access for' do
      common_roles.without('team_lead').each do |role|
        it role do
          expect(subject).to_not permit(public_send(role))
        end
      end
    end
  end

  permissions :destroy? do
    context 'grants access for' do
      adminable_roles.each do |role|
        it role do
          expect(subject).to permit(public_send(role))
        end
      end
    end

    context 'denies access for' do
      common_roles.each do |role|
        it role do
          expect(subject).to_not permit(public_send(role))
        end
      end
    end
  end
end
