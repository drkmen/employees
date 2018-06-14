require 'rails_helper'

RSpec.describe ProjectPolicy do

  let(:other) { FactoryBot.create(:employee, :other) }
  let(:programmer) { FactoryBot.create(:employee, :programmer) }
  let(:system_administrator) { FactoryBot.create(:employee, :system_administrator) }
  let(:manager) { FactoryBot.create(:employee, :manager) }
  let(:team_lead) { FactoryBot.create(:employee, :team_lead) }
  let(:admin) { FactoryBot.create(:employee, :admin) }

  subject { described_class }

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

  permissions :create?, :update?, :destroy? do
    describe 'other CUD project' do
      it 'grants access if employee other CUD his project' do
        expect(subject).to permit(other, other.projects.create(name: 'Project name'))
      end

      it 'denies access if employee other CUD else other project' do
        else_other = FactoryBot.create(:employee, :other)
        project = else_other.projects.create(name: 'Project name')
        expect(subject).not_to permit(other, project)
      end

      it 'denies access if employee other CUD else programmers project' do
        programmer = FactoryBot.create(:employee, :programmer)
        project = programmer.projects.create(name: 'Project name')
        expect(subject).not_to permit(other, project)
      end

      it 'denies access if employee other CUD system_administrator project' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        project = system_administrator.projects.create(name: 'Project name')
        expect(subject).not_to permit(other, project)
      end

      it 'denies access if employee other CUD manager project' do
        manager = FactoryBot.create(:employee, :manager)
        project = manager.projects.create(name: 'Project name')
        expect(subject).not_to permit(other, project)
      end

      it 'denies access if employee other CUD team_lead project' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        project = team_lead.projects.create(name: 'Project name')
        expect(subject).not_to permit(other, project)
      end

      it 'denies access if employee other CUD admin project' do
        admin = FactoryBot.create(:employee, :admin)
        project = admin.projects.create(name: 'Project name')
        expect(subject).not_to permit(other, project)
      end
    end

    describe 'programmer CUD project' do
      it 'denies access if employee programmer CUD other project' do
        other = FactoryBot.create(:employee, :other)
        project = other.projects.create(name: 'Project name')
        expect(subject).not_to permit(programmer, project)
      end

      it 'grants access if employee programmer CUD his project' do
        project = programmer.projects.create(name: 'Project name')
        expect(subject).to permit(programmer, project)
      end

      it 'denies access if employee programmer CUD else programmers project' do
        else_programmer = FactoryBot.create(:employee, :programmer)
        project = else_programmer.projects.create(name: 'Project name')
        expect(subject).not_to permit(programmer, project)
      end

      it 'denies access if employee programmer CUD system_administrator project' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        project = system_administrator.projects.create(name: 'Project name')
        expect(subject).not_to permit(programmer, project)
      end

      it 'denies access if employee programmer CUD manager project' do
        manager = FactoryBot.create(:employee, :manager)
        project = manager.projects.create(name: 'Project name')
        expect(subject).not_to permit(programmer, project)
      end

      it 'denies access if employee programmer CUD team_lead project' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        project = team_lead.projects.create(name: 'Project name')
        expect(subject).not_to permit(programmer, project)
      end

      it 'denies access if employee programmer CUD admin project' do
        admin = FactoryBot.create(:employee, :admin)
        project = admin.projects.create(name: 'Project name')
        expect(subject).not_to permit(programmer, project)
      end
    end

    describe 'system_administrator CUD project' do
      it 'denies access if employee system_administrator CUD other project' do
        other = FactoryBot.create(:employee, :other)
        project = other.projects.create(name: 'Project name')
        expect(subject).not_to permit(system_administrator, project)
      end

      it 'grants access if employee system_administrator CUD his project' do
        project = system_administrator.projects.create(name: 'Project name')
        expect(subject).to permit(system_administrator, project)
      end

      it 'denies access if employee system_administrator CUD programmers project' do
        programmer = FactoryBot.create(:employee, :programmer)
        project = programmer.projects.create(name: 'Project name')
        expect(subject).not_to permit(system_administrator, project)
      end

      it 'denies access if employee system_administrator CUD else system_administrator project' do
        else_system_administrator = FactoryBot.create(:employee, :system_administrator)
        project = else_system_administrator.projects.create(name: 'Project name')
        expect(subject).not_to permit(system_administrator, project)
      end

      it 'denies access if employee system_administrator CUD manager project' do
        manager = FactoryBot.create(:employee, :manager)
        project = manager.projects.create(name: 'Project name')
        expect(subject).not_to permit(system_administrator, project)
      end

      it 'denies access if employee system_administrator CUD team_lead project' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        project = team_lead.projects.create(name: 'Project name')
        expect(subject).not_to permit(system_administrator, project)
      end

      it 'denies access if employee system_administrator CUD admin project' do
        admin = FactoryBot.create(:employee, :admin)
        project = admin.projects.create(name: 'Project name')
        expect(subject).not_to permit(system_administrator, project)
      end
    end

    describe 'manager CUD project' do
      it 'denies access if employee manager CUD other project' do
        other = FactoryBot.create(:employee, :other)
        project = other.projects.create(name: 'Project name')
        expect(subject).not_to permit(manager, project)
      end

      it 'grants access if employee manager CUD programmers project' do
        programmer = FactoryBot.create(:employee, :programmer)
        project = programmer.projects.create(name: 'Project name')
        expect(subject).to permit(manager, project)
      end

      it 'denies access if employee manager CUD system_administrator project' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        project = system_administrator.projects.create(name: 'Project name')
        expect(subject).not_to permit(manager, project)
      end

      it 'grants access if employee manager CUD his project' do
        project = manager.projects.create(name: 'Project name')
        expect(subject).to permit(manager, project)
      end

      it 'grants access if employee manager CUD team_lead project' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        project = team_lead.projects.create(name: 'Project name')
        expect(subject).to permit(manager, project)
      end

      it 'denies access if employee manager CUD admin project' do
        admin = FactoryBot.create(:employee, :admin)
        project = admin.projects.create(name: 'Project name')
        expect(subject).not_to permit(manager, project)
      end
    end

    describe 'team_lead CUD project' do
      it 'denies access if employee team_lead CUD other project' do
        other = FactoryBot.create(:employee, :other)
        project = other.projects.create(name: 'Project name')
        expect(subject).not_to permit(team_lead, project)
      end

      it 'grants access if employee team_lead CUD programmers project' do
        team_lead = FactoryBot.create(:employee, :team_lead, department: 'ruby')
        programmer = FactoryBot.create(:employee, :programmer, department: 'ruby')
        project = programmer.projects.create(name: 'Project name')
        expect(subject).to permit(team_lead, project)
      end

      it 'denies access if employee team_lead CUD programmers project' do
        team_lead = FactoryBot.create(:employee, :team_lead, department: 'ruby')
        programmer = FactoryBot.create(:employee, :programmer, department: 'js')
        project = programmer.projects.create(name: 'Project name')
        expect(subject).not_to permit(team_lead, project)
      end

      it 'denies access if employee team_lead CUD system_administrator project' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        project = system_administrator.projects.create(name: 'Project name')
        expect(subject).not_to permit(team_lead, project)
      end

      it 'denies access if employee team_lead CUD manager project' do
        manager = FactoryBot.create(:employee, :manager)
        project = manager.projects.create(name: 'Project name')
        expect(subject).not_to permit(team_lead, project)
      end

      it 'grants access if employee team_lead CUD his project' do
        project = team_lead.projects.create(name: 'Project name')
        expect(subject).to permit(team_lead, project)
      end

      it 'denies access if employee team_lead CUD else_team_lead project' do
        else_team_lead = FactoryBot.create(:employee, :team_lead)
        project = else_team_lead.projects.create(name: 'Project name')
        expect(subject).not_to permit(team_lead, project)
      end

      it 'denies access if employee team_lead CUD admin project' do
        admin = FactoryBot.create(:employee, :admin)
        project = admin.projects.create(name: 'Project name')
        expect(subject).not_to permit(team_lead, project)
      end
    end

    describe 'admin CUD project' do
      it 'grants access if employee admin CUD other project' do
        other = FactoryBot.create(:employee, :other)
        project = other.projects.create(name: 'Project name')
        expect(subject).to permit(admin, project)
      end

      it 'grants access if employee admin CUD programmers project' do
        programmer = FactoryBot.create(:employee, :programmer)
        project = programmer.projects.create(name: 'Project name')
        expect(subject).to permit(admin, project)
      end

      it 'grants access if employee admin CUD system_administrator project' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        project = system_administrator.projects.create(name: 'Project name')
        expect(subject).to permit(admin, project)
      end

      it 'grants access if employee admin CUD manager project' do
        manager = FactoryBot.create(:employee, :manager)
        project = manager.projects.create(name: 'Project name')
        expect(subject).to permit(admin, project)
      end

      it 'grants access if employee admin CUD team_lead project' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        project = team_lead.projects.create(name: 'Project name')
        expect(subject).to permit(admin, project)
      end

      it 'grants access if employee admin CUD his project' do
        project = admin.projects.create(name: 'Project name')
        expect(subject).to permit(admin, project)
      end
    end

    it 'denies access if not employee' do
      expect(subject).not_to permit
    end
  end
end
