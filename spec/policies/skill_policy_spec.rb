require 'rails_helper'

RSpec.describe SkillPolicy do
  let(:other) { FactoryBot.create(:employee, :other) }
  let(:programmer) { FactoryBot.create(:employee, :programmer) }
  let(:manager) { FactoryBot.create(:employee, :manager) }
  let(:team_lead) { FactoryBot.create(:employee, :team_lead) }
  let(:admin) { FactoryBot.create(:employee, :admin) }

  let(:skill) { FactoryBot.create(:skill) }

  subject { described_class }

  permissions :create?, :update?, :destroy? do
    it 'grants access if employee other' do
      expect(subject).to permit(other, skill)
    end

    it 'grants access if employee programmer' do
      expect(subject).to permit(programmer, skill)
    end

    it 'grants access if employee manager' do
      expect(subject).to permit(manager, skill)
    end

    it 'grants access if employee team_lead' do
      expect(subject).to permit(team_lead, skill)
    end

    it 'grants access if employee admin' do
      expect(subject).to permit(admin, skill)
    end

    it 'denies access if not employee' do
      expect(subject).not_to permit
    end
  end
end
