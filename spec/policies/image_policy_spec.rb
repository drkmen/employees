require 'rails_helper'

RSpec.describe ImagePolicy do

  Employee.roles.keys.each do |role|
    let(role) { FactoryBot.create(:employee, role.to_sym) }
  end

  let(:ruby_dep) { Department.create(name: 'ruby') }
  let(:js_dep) { Department.create(name: 'js') }

  subject { described_class }

  permissions :create?, :update?, :destroy? do
    describe 'other CRUD employee image' do
      it 'grants access if employee other CRUD his images' do
        image = other.create_image(image: 'test.png')
        expect(subject).to permit(other, image)
        project = other.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(other, project_image)
      end

      it 'denies access if employee other CRUD else other image' do
        else_other = FactoryBot.create(:employee, :other)
        image = else_other.create_image(image: 'test.png')
        expect(subject).not_to permit(other, image)
        project = else_other.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(other, project_image)
      end

      it 'denies access if employee other CRUD developer image' do
        developer = FactoryBot.create(:employee, :developer)
        image = developer.create_image(image: 'test.png')
        expect(subject).not_to permit(other, image)
        project = developer.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(other, project_image)
      end

      it 'denies access if employee other CRUD system_administrator image' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        image = system_administrator.create_image(image: 'test.png')
        expect(subject).not_to permit(other, image)
        project = system_administrator.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(other, project_image)
      end

      it 'denies access if employee other CRUD manager image' do
        manager = FactoryBot.create(:employee, :manager)
        image = manager.create_image(image: 'test.png')
        expect(subject).not_to permit(other, image)
        project = manager.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(other, project_image)
      end

      it 'denies access if employee other CRUD team_lead image' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        image = team_lead.create_image(image: 'test.png')
        expect(subject).not_to permit(other, image)
        project = team_lead.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(other, project_image)
      end

      it 'denies access if employee other CRUD admin image' do
        admin = FactoryBot.create(:employee, :admin)
        image = admin.create_image(image: 'test.png')
        expect(subject).not_to permit(other, image)
        project = admin.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(other, project_image)
      end
    end

    describe 'developer CRUD employee image' do
      it 'denies access if employee developer CRUD other image' do
        other = FactoryBot.create(:employee, :other)
        image = other.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, image)
        project = other.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, project_image)
      end

      it 'grants access if employee developer CRUD his image' do
        image = developer.create_image(image: 'test.png')
        expect(subject).to permit(developer, image)
        project = developer.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(developer, project_image)
      end

      it 'denies access if employee developer CRUD else developer image' do
        else_developer = FactoryBot.create(:employee, :developer)
        image = else_developer.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, image)
        project = else_developer.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, project_image)
      end

      it 'denies access if employee developer CRUD system_administrator image' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        image = system_administrator.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, image)
        project = system_administrator.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, project_image)
      end

      it 'denies access if employee developer CRUD manager image' do
        manager = FactoryBot.create(:employee, :manager)
        image = manager.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, image)
        project = manager.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, project_image)
      end

      it 'denies access if employee developer CRUD team_lead image' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        image = team_lead.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, image)
        project = team_lead.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, project_image)
      end

      it 'denies access if employee developer CRUD admin image' do
        admin = FactoryBot.create(:employee, :admin)
        image = admin.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, image)
        project = admin.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, project_image)
      end
    end

    describe 'system_administrator CRUD employee image' do
      it 'denies access if employee system_administrator CRUD other image' do
        other = FactoryBot.create(:employee, :other)
        image = other.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, image)
        project = other.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, project_image)
      end

      it 'grants access if employee system_administrator CRUD his image' do
        image = system_administrator.create_image(image: 'test.png')
        expect(subject).to permit(system_administrator, image)
        project = system_administrator.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(system_administrator, project_image)
      end

      it 'denies access if employee system_administrator CRUD developer image' do
        developer = FactoryBot.create(:employee, :developer)
        image = developer.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, image)
        project = developer.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, project_image)
      end

      it 'denies access if employee system_administrator CRUD else system_administrator image' do
        else_system_administrator = FactoryBot.create(:employee, :system_administrator)
        image = else_system_administrator.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, image)
        project = else_system_administrator.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, project_image)
      end

      it 'denies access if employee system_administrator CRUD manager image' do
        manager = FactoryBot.create(:employee, :manager)
        image = manager.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, image)
        project = manager.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, project_image)
      end

      it 'denies access if employee system_administrator CRUD team_lead image' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        image = team_lead.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, image)
        project = team_lead.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, project_image)
      end

      it 'denies access if employee system_administrator CRUD admin image' do
        admin = FactoryBot.create(:employee, :admin)
        image = admin.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, image)
        project = admin.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, project_image)
      end
    end

    describe 'manager CRUD employee image' do
      it 'denies access if employee manager CRUD other image' do
        other = FactoryBot.create(:employee, :other)
        image = other.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, image)
        project = other.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, project_image)
      end

      it 'grants access if employee manager CRUD developer image' do
        developer = FactoryBot.create(:employee, :developer)
        image = developer.create_image(image: 'test.png')
        expect(subject).to permit(manager, image)
        project = developer.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(manager, project_image)
      end

      it 'denies access if employee manager CRUD system_administrator image' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        image = system_administrator.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, image)
        project = system_administrator.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, project_image)
      end

      it 'grants access if employee manager CRUD his image' do
        image = manager.create_image(image: 'test.png')
        expect(subject).to permit(manager, image)
        project = manager.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(manager, project_image)
      end

      it 'denies access if employee manager CRUD else manager image' do
        else_manager = FactoryBot.create(:employee, :manager)
        image = else_manager.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, image)
        project = else_manager.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, project_image)
      end

      it 'denies access if employee manager CRUD team_lead image' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        image = team_lead.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, image)
        project = team_lead.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, project_image)
      end

      it 'denies access if employee manager CRUD admin image' do
        admin = FactoryBot.create(:employee, :admin)
        image = admin.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, image)
        project = admin.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, project_image)
      end
    end

    describe 'team_lead CRUD employee image' do
      it 'denies access if employee team_lead CRUD other image' do
        other = FactoryBot.create(:employee, :other)
        image = other.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, image)
        project = other.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, project_image)
      end

      it 'grants access if employee team_lead CRUD his department developer image' do
        team_lead = FactoryBot.create(:employee, :team_lead, department: ruby_dep)
        developer = FactoryBot.create(:employee, :developer, department: ruby_dep)
        image = developer.create_image(image: 'test.png')
        expect(subject).to permit(team_lead, image)
        project = developer.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(team_lead, project_image)
      end

      it 'denies access if employee team_lead CRUD not his department developer image' do
        team_lead = FactoryBot.create(:employee, :team_lead, department: ruby_dep)
        developer = FactoryBot.create(:employee, :developer, department: js_dep)
        image = developer.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, image)
        project = developer.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, project_image)
      end

      it 'denies access if employee team_lead CRUD system_administrator image' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        image = system_administrator.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, image)
        project = system_administrator.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, project_image)
      end

      it 'denies access if employee team_lead CRUD manager image' do
        manager = FactoryBot.create(:employee, :manager)
        image = manager.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, image)
        project = manager.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, project_image)
      end

      it 'grants access if employee team_lead CRUD his image' do
        image = team_lead.create_image(image: 'test.png')
        expect(subject).to permit(team_lead, image)
        project = team_lead.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(team_lead, project_image)
      end

      it 'denise access if employee team_lead CRUD else team_lead image' do
        else_team_lead = FactoryBot.create(:employee, :team_lead)
        image = else_team_lead.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, image)
        project = else_team_lead.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, project_image)
      end

      it 'denies access if employee team_lead CRUD admin image' do
        admin = FactoryBot.create(:employee, :admin)
        image = admin.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, image)
        project = admin.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, project_image)
      end
    end

    describe 'admin CRUD employee image' do
      it 'grants access if employee admin CRUD other image' do
        other = FactoryBot.create(:employee, :other)
        image = other.create_image(image: 'test.png')
        expect(subject).to permit(admin, image)
        project = other.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(admin, project_image)
      end

      it 'grants access if employee admin CRUD developer image' do
        developer = FactoryBot.create(:employee, :developer)
        image = developer.create_image(image: 'test.png')
        expect(subject).to permit(admin, image)
        project = developer.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(admin, project_image)
      end

      it 'grants access if employee admin CRUD system_administrator' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        image = developer.create_image(image: 'test.png')
        expect(subject).to permit(admin, image)
        project = system_administrator.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(admin, project_image)
      end

      it 'grants access if employee admin CRUD manager image' do
        manager = FactoryBot.create(:employee, :manager)
        image = manager.create_image(image: 'test.png')
        expect(subject).to permit(admin, image)
        project = manager.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(admin, project_image)
      end

      it 'grants access if employee admin CRUD team_lead image' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        image = team_lead.create_image(image: 'test.png')
        expect(subject).to permit(admin, image)
        project = team_lead.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(admin, project_image)
      end

      it 'grants access if employee admin CRUD his image' do
        image = admin.create_image(image: 'test.png')
        expect(subject).to permit(admin, image)
        project = admin.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(admin, project_image)
      end
    end

    it 'denies access if not employee' do
      expect(subject).not_to permit
    end
  end
end
