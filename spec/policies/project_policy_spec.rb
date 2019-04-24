require 'rails_helper'

RSpec.describe ProjectPolicy do

  Employee.roles.keys.each do |role|
    let(role) { FactoryBot.create(:employee, role.to_sym) }
  end

  subject { described_class }

  let(:ruby_dep) { Department.create(name: 'ruby') }
  let(:js_dep) { Department.create(name: 'js') }

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

  permissions :create?, :update?, :destroy? do
    describe 'other CRUD project' do
      it 'grants access if employee other CRUD his project' do
        expect(subject).to permit(other, other.projects.create(name: 'Project name'))
      end

      it 'denies access if employee other CRUD else other project' do
        else_other = FactoryBot.create(:employee, :other)
        project = else_other.projects.create(name: 'Project name')
        expect(subject).not_to permit(other, project)
      end

      it 'denies access if employee other CRUD else developers project' do
        developer = FactoryBot.create(:employee, :developer)
        project = developer.projects.create(name: 'Project name')
        expect(subject).not_to permit(other, project)
      end

      it 'denies access if employee other CRUD system_administrator project' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        project = system_administrator.projects.create(name: 'Project name')
        expect(subject).not_to permit(other, project)
      end

      it 'denies access if employee other CRUD manager project' do
        manager = FactoryBot.create(:employee, :manager)
        project = manager.projects.create(name: 'Project name')
        expect(subject).not_to permit(other, project)
      end

      it 'denies access if employee other CRUD team_lead project' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        project = team_lead.projects.create(name: 'Project name')
        expect(subject).not_to permit(other, project)
      end

      it 'denies access if employee other CRUD admin project' do
        admin = FactoryBot.create(:employee, :admin)
        project = admin.projects.create(name: 'Project name')
        expect(subject).not_to permit(other, project)
      end
    end

    describe 'developer CRUD project' do
      it 'denies access if employee developer CRUD other project' do
        other = FactoryBot.create(:employee, :other)
        project = other.projects.create(name: 'Project name')
        expect(subject).not_to permit(developer, project)
      end

      it 'grants access if employee developer CRUD his project' do
        project = developer.projects.create(name: 'Project name')
        expect(subject).to permit(developer, project)
      end

      it 'denies access if employee developer CRUD else developers project' do
        else_developer = FactoryBot.create(:employee, :developer)
        project = else_developer.projects.create(name: 'Project name')
        expect(subject).not_to permit(developer, project)
      end

      it 'denies access if employee developer CRUD system_administrator project' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        project = system_administrator.projects.create(name: 'Project name')
        expect(subject).not_to permit(developer, project)
      end

      it 'denies access if employee developer CRUD manager project' do
        manager = FactoryBot.create(:employee, :manager)
        project = manager.projects.create(name: 'Project name')
        expect(subject).not_to permit(developer, project)
      end

      it 'denies access if employee developer CRUD team_lead project' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        project = team_lead.projects.create(name: 'Project name')
        expect(subject).not_to permit(developer, project)
      end

      it 'denies access if employee developer CRUD admin project' do
        admin = FactoryBot.create(:employee, :admin)
        project = admin.projects.create(name: 'Project name')
        expect(subject).not_to permit(developer, project)
      end
    end

    describe 'system_administrator CRUD project' do
      it 'denies access if employee system_administrator CRUD other project' do
        other = FactoryBot.create(:employee, :other)
        project = other.projects.create(name: 'Project name')
        expect(subject).not_to permit(system_administrator, project)
      end

      it 'grants access if employee system_administrator CRUD his project' do
        project = system_administrator.projects.create(name: 'Project name')
        expect(subject).to permit(system_administrator, project)
      end

      it 'denies access if employee system_administrator CRUD developers project' do
        developer = FactoryBot.create(:employee, :developer)
        project = developer.projects.create(name: 'Project name')
        expect(subject).not_to permit(system_administrator, project)
      end

      it 'denies access if employee system_administrator CRUD else system_administrator project' do
        else_system_administrator = FactoryBot.create(:employee, :system_administrator)
        project = else_system_administrator.projects.create(name: 'Project name')
        expect(subject).not_to permit(system_administrator, project)
      end

      it 'denies access if employee system_administrator CRUD manager project' do
        manager = FactoryBot.create(:employee, :manager)
        project = manager.projects.create(name: 'Project name')
        expect(subject).not_to permit(system_administrator, project)
      end

      it 'denies access if employee system_administrator CRUD team_lead project' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        project = team_lead.projects.create(name: 'Project name')
        expect(subject).not_to permit(system_administrator, project)
      end

      it 'denies access if employee system_administrator CRUD admin project' do
        admin = FactoryBot.create(:employee, :admin)
        project = admin.projects.create(name: 'Project name')
        expect(subject).not_to permit(system_administrator, project)
      end
    end

    describe 'manager CRUD project' do
      it 'denies access if employee manager CRUD other project' do
        other = FactoryBot.create(:employee, :other)
        project = other.projects.create(name: 'Project name')
        expect(subject).not_to permit(manager, project)
      end

      it 'grants access if employee manager CRUD developers project' do
        developer = FactoryBot.create(:employee, :developer)
        project = developer.projects.create(name: 'Project name')
        expect(subject).to permit(manager, project)
      end

      it 'denies access if employee manager CRUD system_administrator project' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        project = system_administrator.projects.create(name: 'Project name')
        expect(subject).not_to permit(manager, project)
      end

      it 'grants access if employee manager CRUD his project' do
        project = manager.projects.create(name: 'Project name')
        expect(subject).to permit(manager, project)
      end

      it 'grants access if employee manager CRUD team_lead project' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        project = team_lead.projects.create(name: 'Project name')
        expect(subject).to permit(manager, project)
      end

      it 'denies access if employee manager CRUD admin project' do
        admin = FactoryBot.create(:employee, :admin)
        project = admin.projects.create(name: 'Project name')
        expect(subject).not_to permit(manager, project)
      end
    end

    describe 'team_lead CRUD project' do
      it 'denies access if employee team_lead CRUD other project' do
        other = FactoryBot.create(:employee, :other)
        project = other.projects.create(name: 'Project name')
        expect(subject).not_to permit(team_lead, project)
      end

      it 'grants access if employee team_lead CRUD developers project' do
        team_lead = FactoryBot.create(:employee, :team_lead, department: ruby_dep)
        developer = FactoryBot.create(:employee, :developer, department: ruby_dep)
        project = developer.projects.create(name: 'Project name')
        expect(subject).to permit(team_lead, project)
      end

      it 'denies access if employee team_lead CRUD developers project' do
        team_lead = FactoryBot.create(:employee, :team_lead, department: ruby_dep)
        developer = FactoryBot.create(:employee, :developer, department: js_dep)
        project = developer.projects.create(name: 'Project name')
        expect(subject).not_to permit(team_lead, project)
      end

      it 'denies access if employee team_lead CRUD system_administrator project' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        project = system_administrator.projects.create(name: 'Project name')
        expect(subject).not_to permit(team_lead, project)
      end

      it 'denies access if employee team_lead CRUD manager project' do
        manager = FactoryBot.create(:employee, :manager)
        project = manager.projects.create(name: 'Project name')
        expect(subject).not_to permit(team_lead, project)
      end

      it 'grants access if employee team_lead CRUD his project' do
        project = team_lead.projects.create(name: 'Project name')
        expect(subject).to permit(team_lead, project)
      end

      it 'denies access if employee team_lead CRUD else_team_lead project' do
        else_team_lead = FactoryBot.create(:employee, :team_lead)
        project = else_team_lead.projects.create(name: 'Project name')
        expect(subject).not_to permit(team_lead, project)
      end

      it 'denies access if employee team_lead CRUD admin project' do
        admin = FactoryBot.create(:employee, :admin)
        project = admin.projects.create(name: 'Project name')
        expect(subject).not_to permit(team_lead, project)
      end
    end

    describe 'admin CRUD project' do
      it 'grants access if employee admin CRUD other project' do
        other = FactoryBot.create(:employee, :other)
        project = other.projects.create(name: 'Project name')
        expect(subject).to permit(admin, project)
      end

      it 'grants access if employee admin CRUD developers project' do
        developer = FactoryBot.create(:employee, :developer)
        project = developer.projects.create(name: 'Project name')
        expect(subject).to permit(admin, project)
      end

      it 'grants access if employee admin CRUD system_administrator project' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        project = system_administrator.projects.create(name: 'Project name')
        expect(subject).to permit(admin, project)
      end

      it 'grants access if employee admin CRUD manager project' do
        manager = FactoryBot.create(:employee, :manager)
        project = manager.projects.create(name: 'Project name')
        expect(subject).to permit(admin, project)
      end

      it 'grants access if employee admin CRUD team_lead project' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        project = team_lead.projects.create(name: 'Project name')
        expect(subject).to permit(admin, project)
      end

      it 'grants access if employee admin CRUD his project' do
        project = admin.projects.create(name: 'Project name')
        expect(subject).to permit(admin, project)
      end
    end

    it 'denies access if not employee' do
      expect(subject).not_to permit
    end
  end
end
