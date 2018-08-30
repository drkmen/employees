require 'rails_helper'

RSpec.describe EmployeePolicy do

  let(:other) { FactoryBot.create(:employee, :other) }
  let(:developer) { FactoryBot.create(:employee, :developer) }
  let(:system_administrator) { FactoryBot.create(:employee, :system_administrator) }
  let(:manager) { FactoryBot.create(:employee, :manager) }
  let(:team_lead) { FactoryBot.create(:employee, :team_lead) }
  let(:admin) { FactoryBot.create(:employee, :admin) }

  subject { described_class }

  permissions :index?, :show? do
    it 'grants access if employee other' do
      expect(subject).to permit(other)
    end

    it 'grants access if employee developer' do
      expect(subject).to permit(developer)
    end

    it 'grants access if employee system_administrator' do
      expect(subject).to permit(system_administrator)
    end

    it 'grants access if employee manager' do
      expect(subject).to permit(manager)
    end

    it 'grants access if employee team_lead' do
      expect(subject).to permit(team_lead)
    end

    it 'grants access if employee admin' do
      expect(subject).to permit(admin)
    end

    it 'grants access if not employee' do
      expect(subject).to permit
    end
  end

  permissions :edit? do
    it 'denies access if employee other' do
      expect(subject).not_to permit(other)
    end

    it 'denies access if employee developer' do
      expect(subject).not_to permit(developer)
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

  permissions :create?, :destroy? do
    it 'grants access if employee admin' do
      expect(subject).to permit(admin)
    end

    it 'grants access if employee manager' do
      expect(subject).to permit(manager)
    end

    it 'denies access if employee other' do
      expect(subject).not_to permit(other)
    end

    it 'denies access if employee developer' do
      expect(subject).not_to permit(developer)
    end

    it 'denies access if employee system_administrator' do
      expect(subject).not_to permit(system_administrator)
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

      it 'denies access if employee other edit employee developer' do
        expect(subject).not_to permit(other, developer)
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

    describe 'developer edit employee' do
      it 'grants access if employee developer edit self' do
        developer = FactoryBot.create(:employee, :developer)
        expect(subject).to permit(developer, developer)
      end

      it 'denies access if employee developer edit other employee developer' do
        edit_developer = FactoryBot.create(:employee, :developer, department: 'ruby')
        expect(subject).not_to permit(developer, edit_developer)
      end

      it 'denies access if employee developer edit employee manager' do
        expect(subject).not_to permit(developer, manager)
      end

      it 'denies access if employee developer edit employee team_lead' do
        expect(subject).not_to permit(developer, team_lead)
      end

      it 'denies access if employee developer edit employee admin' do
        expect(subject).not_to permit(developer, admin)
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

      it 'denies access if employee system_administrator edit employee developer' do
        expect(subject).not_to permit(system_administrator, developer)
      end

      it 'denies access if employee system_administrator edit employee manager' do
        expect(subject).not_to permit(developer, manager)
      end

      it 'denies access if employee system_administrator edit employee team_lead' do
        expect(subject).not_to permit(developer, team_lead)
      end

      it 'denies access if employee system_administrator edit employee admin' do
        expect(subject).not_to permit(developer, admin)
      end
    end

    describe 'manager edit employee' do
      it 'grants access if employee manager edit self' do
        manager = FactoryBot.create(:employee, :manager)
        expect(subject).to permit(manager, manager)
      end

      it 'grants access if employee manager edit developer' do
        expect(subject).to permit(manager, developer)
      end

      it 'denies access if employee manager edit employee other' do
        expect(subject).not_to permit(manager, other)
      end

      it 'denies access if employee manager edit employee team_lead' do
        expect(subject).to permit(manager, team_lead)
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

      it 'grants access if employee team_lead edit developer from his department' do
        team_lead = FactoryBot.create(:employee, :team_lead, department: 'ruby')
        developer = FactoryBot.create(:employee, :developer, department: 'ruby')
        expect(subject).to permit(team_lead, developer)
      end

      it 'denies access if employee team_lead edited employee other' do
        expect(subject).not_to permit(team_lead, other)
      end

      it 'denies access if employee team_lead edited employee developer other department' do
        team_lead = FactoryBot.create(:employee, :team_lead, department: 'js')
        other_dept_developer = FactoryBot.create(:employee, :developer, department: 'ruby')
        expect(subject).not_to permit(team_lead, other_dept_developer)
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

      it 'grants access if employee admin edit employee developer' do
        expect(subject).to permit(admin, developer)
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
