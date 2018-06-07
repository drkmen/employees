require 'rails_helper'

RSpec.describe EmployeePolicy do

  let(:other) { FactoryBot.create(:employee, :other) }
  let(:programmer) { FactoryBot.create(:employee, :programmer) }
  let(:system_administrator) { FactoryBot.create(:employee, :system_administrator) }
  let(:manager) { FactoryBot.create(:employee, :manager) }
  let(:team_lead) { FactoryBot.create(:employee, :team_lead) }
  let(:admin) { FactoryBot.create(:employee, :admin) }

  subject { described_class }

  permissions :create?, :destroy? do
    it 'grants access if employee admin' do
      expect(subject).to permit(admin)
    end

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

    it 'denies access if not employee' do
      expect(subject).not_to permit
    end
  end

  permissions :update? do
    describe 'other edit employee' do
      it 'grants access if employee other edit self' do
        other = FactoryBot.create(:employee, :other)
        expect(subject).to permit(other, other)
      end

      it 'denies access if employee other edit other employee other' do
        edit_other = FactoryBot.create(:employee, :other)
        expect(subject).not_to permit(other, edit_other)
      end

      it 'denies access if employee other edit employee programmer' do
        expect(subject).not_to permit(other, programmer)
      end

      it 'denies access if employee other edit employee manager' do
        expect(subject).not_to permit(other, manager)
      end

      it 'denies access if employee other edit employee team_lead' do
        expect(subject).not_to permit(other, team_lead)
      end

      it 'denies access if employee other edit employee admin' do
        expect(subject).not_to permit(other, admin)
      end
    end

    describe 'programmer edit employee' do
      it 'grants access if employee programmer edit self' do
        programmer = FactoryBot.create(:employee, :programmer)
        expect(subject).to permit(programmer, programmer)
      end

      it 'denies access if employee programmer edit other employee programmer' do
        edit_programmer = FactoryBot.create(:employee, :programmer, department: 'ruby')
        expect(subject).not_to permit(programmer, edit_programmer)
      end

      it 'denies access if employee programmer edit employee manager' do
        expect(subject).not_to permit(programmer, manager)
      end

      it 'denies access if employee programmer edit employee team_lead' do
        expect(subject).not_to permit(programmer, team_lead)
      end

      it 'denies access if employee programmer edit employee admin' do
        expect(subject).not_to permit(programmer, admin)
      end
    end

    describe 'system_administrator edit employee' do
      it 'grants access if employee system_administrator edit self' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        expect(subject).to permit(system_administrator, system_administrator)
      end

      it 'denies access if employee system_administrator edit other employee system_administrator' do
        edit_system_administrator = FactoryBot.create(:employee, :system_administrator)
        expect(subject).not_to permit(system_administrator, edit_system_administrator)
      end

      it 'denies access if employee system_administrator edit employee programmer' do
        expect(subject).not_to permit(system_administrator, programmer)
      end

      it 'denies access if employee system_administrator edit employee manager' do
        expect(subject).not_to permit(programmer, manager)
      end

      it 'denies access if employee system_administrator edit employee team_lead' do
        expect(subject).not_to permit(programmer, team_lead)
      end

      it 'denies access if employee system_administrator edit employee admin' do
        expect(subject).not_to permit(programmer, admin)
      end
    end

    describe 'manager edit employee' do
      it 'grants access if employee manager edit self' do
        manager = FactoryBot.create(:employee, :manager)
        expect(subject).to permit(manager, manager)
      end

      it 'grants access if employee manager edit programmer' do
        expect(subject).to permit(manager, programmer)
      end

      it 'denies access if employee manager edit employee other' do
        expect(subject).not_to permit(manager, other)
      end

      it 'denies access if employee manager edit employee team_lead' do
        expect(subject).not_to permit(manager, team_lead)
      end

      it 'denies access if employee manager edit employee admin' do
        expect(subject).not_to permit(manager, admin)
      end

      it 'denies access if employee manager edit other manager' do
        edit_manager = FactoryBot.create(:employee, :manager)
        expect(subject).not_to permit(manager, edit_manager)
      end
    end

    describe 'team_lead edit employee' do
      it 'grants access if employee team_lead edit self' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        expect(subject).to permit(team_lead, team_lead)
      end

      it 'grants access if employee team_lead edit programmer from his department' do
        team_lead = FactoryBot.create(:employee, :team_lead, department: 'ruby')
        programmer = FactoryBot.create(:employee, :programmer, department: 'ruby')
        expect(subject).to permit(team_lead, programmer)
      end

      it 'denies access if employee team_lead edited employee other' do
        expect(subject).not_to permit(team_lead, other)
      end

      it 'denies access if employee team_lead edited employee programmer other department' do
        other_dept_programmer = FactoryBot.create(:employee, :programmer, department: 'ruby')
        expect(subject).not_to permit(team_lead, other_dept_programmer)
      end

      it 'denies access if employee team_lead edit employee manager' do
        expect(subject).not_to permit(team_lead, manager)
      end

      it 'denies access if employee team_lead edit other employee team_lead' do
        second_team_lead = FactoryBot.create(:employee, :team_lead, department: 'ruby')
        expect(subject).not_to permit(team_lead, second_team_lead)
      end

      it 'denies access if employee team_lead edit other employee team_lead from same dept' do
        first_team_lead = FactoryBot.create(:employee, :team_lead, department: 'ruby')
        second_team_lead = FactoryBot.create(:employee, :team_lead, department: 'ruby')
        expect(subject).not_to permit(first_team_lead, second_team_lead)
      end

      it 'denies access if employee team_lead edit employee admin' do
        expect(subject).not_to permit(team_lead, admin)
      end
    end

    describe 'admin edit employee' do
      it 'grants access if employee admin edit employee other' do
        expect(subject).to permit(admin, other)
      end

      it 'grants access if employee admin edit employee programmer' do
        expect(subject).to permit(admin, programmer)
      end

      it 'grants access if employee admin edit employee manager' do
        expect(subject).to permit(admin, manager)
      end

      it 'grants access if employee admin edit employee team_lead' do
        expect(subject).to permit(admin, team_lead)
      end

      it 'grants access if employee admin edit employee admin' do
        expect(subject).to permit(admin, admin)
      end
    end

    it 'denies access if not employee' do
      expect(subject).not_to permit
    end
  end
end
