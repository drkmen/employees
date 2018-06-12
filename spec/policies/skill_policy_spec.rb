require 'rails_helper'

RSpec.describe SkillPolicy do
  let(:other) { FactoryBot.create(:employee, :other) }
  let(:programmer) { FactoryBot.create(:employee, :programmer) }
  let(:system_administrator) { FactoryBot.create(:employee, :system_administrator) }
  let(:manager) { FactoryBot.create(:employee, :manager) }
  let(:team_lead) { FactoryBot.create(:employee, :team_lead) }
  let(:admin) { FactoryBot.create(:employee, :admin) }

  let(:skill) { FactoryBot.create(:skill) }

  subject { described_class }

  permissions :create? do
    it 'grants access if employee other' do
      expect(subject).to permit(other, skill)
    end

    it 'grants access if employee programmer' do
      expect(subject).to permit(programmer, skill)
    end

    it 'grants access if employee system_administrator' do
      expect(subject).to permit(system_administrator, skill)
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

  permissions :edit? do
    it 'denies access if employee other' do
      expect(subject).not_to permit(other)
    end

    it 'denies access if employee programmer' do
      expect(subject).not_to permit(programmer)
    end

    it 'denies access if employee system_administrator' do
      expect(subject).not_to permit(system_administrator)
    end

    it 'denies access if employee manager' do
      expect(subject).not_to permit(manager)
    end

    it 'denies access if employee team_lead' do
      expect(subject).not_to permit(team_lead)
    end

    it 'denies access if employee admin' do
      expect(subject).not_to permit(admin)
    end

    it 'denies access if not employee' do
      expect(subject).not_to permit
    end
  end

  permissions :update?, :destroy? do
    describe 'other edit/destroy skill' do
      it 'grants access if employee other edit/destroy his skill' do
        skill = FactoryBot.create(:skill, employee_id: other.id)
        expect(subject).to permit(other, skill)
      end

      it 'denies access if employee other edit/destroy else other skill' do
        else_other = FactoryBot.create(:employee, :other)
        skill = FactoryBot.create(:skill, employee_id: else_other.id)
        expect(subject).not_to permit(other, skill)
      end

      it 'denies access if employee other edit/destroy programmer skill' do
        programmer = FactoryBot.create(:employee, :programmer)
        skill = FactoryBot.create(:skill, employee_id: programmer.id)
        expect(subject).not_to permit(other, skill)
      end

      it 'denies access if employee other edit/destroy system_administrator skill' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        skill = FactoryBot.create(:skill, employee_id: system_administrator.id)
        expect(subject).not_to permit(other, skill)
      end

      it 'denies access if employee other edit/destroy manager skill' do
        manager = FactoryBot.create(:employee, :manager)
        skill = FactoryBot.create(:skill, employee_id: manager.id)
        expect(subject).not_to permit(other, skill)
        end

      it 'denies access if employee other edit/destroy team_lead skill' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        skill = FactoryBot.create(:skill, employee_id: team_lead.id)
        expect(subject).not_to permit(other, skill)
      end

      it 'denies access if employee other edit/destroy admin skill' do
        admin = FactoryBot.create(:employee, :admin)
        skill = FactoryBot.create(:skill, employee_id: admin.id)
        expect(subject).not_to permit(other, skill)
      end

      it 'denies access if employee other edit/destroy skill without owner' do
        skill = FactoryBot.create(:skill)
        expect(subject).not_to permit(other, skill)
      end
    end

    describe 'programmer edit/destroy skill' do
      it 'denies access if employee programmer edit/destroy other skill' do
        other = FactoryBot.create(:employee, :other)
        skill = FactoryBot.create(:skill, employee_id: other.id)
        expect(subject).not_to permit(programmer, skill)
      end

      it 'grants access if employee programmer edit/destroy his skill' do
        skill = FactoryBot.create(:skill, employee_id: programmer.id)
        expect(subject).to permit(programmer, skill)
      end

      it 'denies access if employee programmer edit/destroy else programmer skill' do
        else_programmer = FactoryBot.create(:employee, :programmer)
        skill = FactoryBot.create(:skill, employee_id: else_programmer.id)
        expect(subject).not_to permit(programmer, skill)
      end

      it 'denies access if employee programmer edit/destroy system_administrator skill' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        skill = FactoryBot.create(:skill, employee_id: system_administrator.id)
        expect(subject).not_to permit(programmer, skill)
      end

      it 'denies access if employee programmer edit/destroy manager skill' do
        manager = FactoryBot.create(:employee, :manager)
        skill = FactoryBot.create(:skill, employee_id: manager.id)
        expect(subject).not_to permit(programmer, skill)
      end

      it 'denies access if employee programmer edit/destroy team_lead skill' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        skill = FactoryBot.create(:skill, employee_id: team_lead.id)
        expect(subject).not_to permit(programmer, skill)
      end

      it 'denies access if employee programmer edit/destroy admin skill' do
        admin = FactoryBot.create(:employee, :admin)
        skill = FactoryBot.create(:skill, employee_id: admin.id)
        expect(subject).not_to permit(programmer, skill)
      end

      it 'denies access if employee programmer edit/destroy skill without owner' do
        skill = FactoryBot.create(:skill)
        expect(subject).not_to permit(programmer, skill)
      end
    end

    describe 'system_administrator edit/destroy skill' do
      it 'denies access if employee system_administrator edit/destroy other skill' do
        other = FactoryBot.create(:employee, :other)
        skill = FactoryBot.create(:skill, employee_id: other.id)
        expect(subject).not_to permit(system_administrator, skill)
      end

      it 'denies access if employee system_administrator edit/destroy programmer skill' do
        programmer = FactoryBot.create(:employee, :programmer)
        skill = FactoryBot.create(:skill, employee_id: programmer.id)
        expect(subject).not_to permit(system_administrator, skill)
      end

      it 'grants access if employee system_administrator edit/destroy his skill' do
        skill = FactoryBot.create(:skill, employee_id: system_administrator.id)
        expect(subject).to permit(system_administrator, skill)
      end

      it 'denies access if employee system_administrator edit/destroy else system_administrator skill' do
        else_system_administrator = FactoryBot.create(:employee, :system_administrator)
        skill = FactoryBot.create(:skill, employee_id: else_system_administrator.id)
        expect(subject).not_to permit(system_administrator, skill)
      end

      it 'denies access if employee system_administrator edit/destroy manager skill' do
        manager = FactoryBot.create(:employee, :manager)
        skill = FactoryBot.create(:skill, employee_id: manager.id)
        expect(subject).not_to permit(system_administrator, skill)
      end

      it 'denies access if employee system_administrator edit/destroy team_lead skill' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        skill = FactoryBot.create(:skill, employee_id: team_lead.id)
        expect(subject).not_to permit(system_administrator, skill)
      end

      it 'denies access if employee system_administrator edit/destroy admin skill' do
        admin = FactoryBot.create(:employee, :admin)
        skill = FactoryBot.create(:skill, employee_id: admin.id)
        expect(subject).not_to permit(system_administrator, skill)
      end

      it 'denies access if employee system_administrator edit/destroy skill without owner' do
        skill = FactoryBot.create(:skill)
        expect(subject).not_to permit(system_administrator, skill)
      end
    end

    describe 'other edit/destroy skill' do
      it 'denies access if employee manager edit/destroy other skill' do
        other = FactoryBot.create(:employee, :other)
        skill = FactoryBot.create(:skill, employee_id: other.id)
        expect(subject).not_to permit(manager, skill)
      end

      it 'denies access if employee manager edit/destroy programmer skill' do
        programmer = FactoryBot.create(:employee, :programmer)
        skill = FactoryBot.create(:skill, employee_id: programmer.id)
        expect(subject).not_to permit(manager, skill)
      end

      it 'denies access if employee manager edit/destroy system_administrator skill' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        skill = FactoryBot.create(:skill, employee_id: system_administrator.id)
        expect(subject).not_to permit(manager, skill)
      end

      it 'grants access if employee manager edit/destroy his skill' do
        skill = FactoryBot.create(:skill, employee_id: manager.id)
        expect(subject).to permit(manager, skill)
      end

      it 'denies access if employee manager edit/destroy else manager skill' do
        else_manager = FactoryBot.create(:employee, :other)
        skill = FactoryBot.create(:skill, employee_id: else_manager.id)
        expect(subject).not_to permit(manager, skill)
      end

      it 'denies access if employee manager edit/destroy team_lead skill' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        skill = FactoryBot.create(:skill, employee_id: team_lead.id)
        expect(subject).not_to permit(manager, skill)
      end

      it 'denies access if employee manager edit/destroy admin skill' do
        admin = FactoryBot.create(:employee, :admin)
        skill = FactoryBot.create(:skill, employee_id: admin.id)
        expect(subject).not_to permit(manager, skill)
      end

      it 'denies access if employee other edit/destroy skill without owner' do
        skill = FactoryBot.create(:skill)
        expect(subject).not_to permit(manager, skill)
      end
    end

    describe 'team_lead edit/destroy skill' do
      it 'denies access if employee team_lead edit/destroy other skill' do
        other = FactoryBot.create(:employee, :other)
        skill = FactoryBot.create(:skill, employee_id: other.id)
        expect(subject).not_to permit(team_lead, skill)
      end

      it 'denies access if employee team_lead edit/destroy programmer skill' do
        programmer = FactoryBot.create(:employee, :programmer)
        skill = FactoryBot.create(:skill, employee_id: programmer.id)
        expect(subject).not_to permit(team_lead, skill)
      end

      it 'denies access if employee team_lead edit/destroy system_administrator skill' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        skill = FactoryBot.create(:skill, employee_id: system_administrator.id)
        expect(subject).not_to permit(team_lead, skill)
      end

      it 'denies access if employee team_lead edit/destroy manager skill' do
        manager = FactoryBot.create(:employee, :manager)
        skill = FactoryBot.create(:skill, employee_id: manager.id)
        expect(subject).not_to permit(team_lead, skill)
      end

      it 'grants access if employee team_lead edit/destroy his skill' do
        skill = FactoryBot.create(:skill, employee_id: team_lead.id)
        expect(subject).to permit(team_lead, skill)
      end

      it 'denies access if employee team_lead edit/destroy else team_lead skill' do
        else_team_lead = FactoryBot.create(:employee, :other)
        skill = FactoryBot.create(:skill, employee_id: else_team_lead.id)
        expect(subject).not_to permit(team_lead, skill)
      end

      it 'denies access if employee team_lead edit/destroy admin skill' do
        admin = FactoryBot.create(:employee, :admin)
        skill = FactoryBot.create(:skill, employee_id: admin.id)
        expect(subject).not_to permit(team_lead, skill)
      end

      it 'denies access if employee other edit/destroy skill without owner' do
        skill = FactoryBot.create(:skill)
        expect(subject).not_to permit(team_lead, skill)
      end
    end

    describe 'admin edit/destroy skill' do
      it 'denies access if employee admin edit/destroy other skill' do
        other = FactoryBot.create(:employee, :other)
        skill = FactoryBot.create(:skill, employee_id: other.id)
        expect(subject).not_to permit(admin, skill)
      end

      it 'denies access if employee admin edit/destroy programmer skill' do
        programmer = FactoryBot.create(:employee, :programmer)
        skill = FactoryBot.create(:skill, employee_id: programmer.id)
        expect(subject).not_to permit(admin, skill)
      end

      it 'denies access if employee admin edit/destroy system_administrator skill' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        skill = FactoryBot.create(:skill, employee_id: system_administrator.id)
        expect(subject).not_to permit(admin, skill)
      end

      it 'denies access if employee admin edit/destroy manager skill' do
        manager = FactoryBot.create(:employee, :manager)
        skill = FactoryBot.create(:skill, employee_id: manager.id)
        expect(subject).not_to permit(admin, skill)
      end

      it 'denies access if employee admin edit/destroy team_lead skill' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        skill = FactoryBot.create(:skill, employee_id: team_lead.id)
        expect(subject).not_to permit(admin, skill)
      end

      it 'grants access if employee admin edit/destroy his skill' do
        skill = FactoryBot.create(:skill, employee_id: admin.id)
        expect(subject).to permit(admin, skill)
      end

      it 'denies access if employee admin edit/destroy else admin skill' do
        else_admin = FactoryBot.create(:employee, :other)
        skill = FactoryBot.create(:skill, employee_id: else_admin.id)
        expect(subject).not_to permit(admin, skill)
      end

      it 'denies access if employee admin edit/destroy skill without owner' do
        skill = FactoryBot.create(:skill)
        expect(subject).not_to permit(admin, skill)
      end
    end

    it 'denies access if not employee' do
      expect(subject).not_to permit
    end
  end
end
