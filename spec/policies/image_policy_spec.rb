require 'rails_helper'

RSpec.describe ImagePolicy do

  let(:other) { FactoryBot.create(:employee, :other) }
  let(:developer) { FactoryBot.create(:employee, :developer) }
  let(:system_administrator) { FactoryBot.create(:employee, :system_administrator) }
  let(:manager) { FactoryBot.create(:employee, :manager) }
  let(:team_lead) { FactoryBot.create(:employee, :team_lead) }
  let(:admin) { FactoryBot.create(:employee, :admin) }

  subject { described_class }

  permissions :create?, :update?, :destroy? do
    describe 'other CUD employee image' do
      it 'grants access if employee other CUD his images' do
        image = other.create_image(image: 'test.png')
        expect(subject).to permit(other, image)
        project = other.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(other, project_image)
      end

      it 'denies access if employee other CUD else other image' do
        else_other = FactoryBot.create(:employee, :other)
        image = else_other.create_image(image: 'test.png')
        expect(subject).not_to permit(other, image)
        project = else_other.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(other, project_image)
      end

      it 'denies access if employee other CUD developer image' do
        developer = FactoryBot.create(:employee, :developer)
        image = developer.create_image(image: 'test.png')
        expect(subject).not_to permit(other, image)
        project = developer.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(other, project_image)
      end

      it 'denies access if employee other CUD system_administrator image' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        image = system_administrator.create_image(image: 'test.png')
        expect(subject).not_to permit(other, image)
        project = system_administrator.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(other, project_image)
      end

      it 'denies access if employee other CUD manager image' do
        manager = FactoryBot.create(:employee, :manager)
        image = manager.create_image(image: 'test.png')
        expect(subject).not_to permit(other, image)
        project = manager.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(other, project_image)
      end

      it 'denies access if employee other CUD team_lead image' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        image = team_lead.create_image(image: 'test.png')
        expect(subject).not_to permit(other, image)
        project = team_lead.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(other, project_image)
      end

      it 'denies access if employee other CUD admin image' do
        admin = FactoryBot.create(:employee, :admin)
        image = admin.create_image(image: 'test.png')
        expect(subject).not_to permit(other, image)
        project = admin.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(other, project_image)
      end
    end

    describe 'developer CUD employee image' do
      it 'denies access if employee developer CUD other image' do
        other = FactoryBot.create(:employee, :other)
        image = other.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, image)
        project = other.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, project_image)
      end

      it 'grants access if employee developer CUD his image' do
        image = developer.create_image(image: 'test.png')
        expect(subject).to permit(developer, image)
        project = developer.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(developer, project_image)
      end

      it 'denies access if employee developer CUD else developer image' do
        else_developer = FactoryBot.create(:employee, :developer)
        image = else_developer.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, image)
        project = else_developer.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, project_image)
      end

      it 'denies access if employee developer CUD system_administrator image' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        image = system_administrator.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, image)
        project = system_administrator.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, project_image)
      end

      it 'denies access if employee developer CUD manager image' do
        manager = FactoryBot.create(:employee, :manager)
        image = manager.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, image)
        project = manager.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, project_image)
      end

      it 'denies access if employee developer CUD team_lead image' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        image = team_lead.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, image)
        project = team_lead.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, project_image)
      end

      it 'denies access if employee developer CUD admin image' do
        admin = FactoryBot.create(:employee, :admin)
        image = admin.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, image)
        project = admin.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(developer, project_image)
      end
    end

    describe 'system_administrator CUD employee image' do
      it 'denies access if employee system_administrator CUD other image' do
        other = FactoryBot.create(:employee, :other)
        image = other.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, image)
        project = other.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, project_image)
      end

      it 'grants access if employee system_administrator CUD his image' do
        image = system_administrator.create_image(image: 'test.png')
        expect(subject).to permit(system_administrator, image)
        project = system_administrator.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(system_administrator, project_image)
      end

      it 'denies access if employee system_administrator CUD developer image' do
        developer = FactoryBot.create(:employee, :developer)
        image = developer.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, image)
        project = developer.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, project_image)
      end

      it 'denies access if employee system_administrator CUD else system_administrator image' do
        else_system_administrator = FactoryBot.create(:employee, :system_administrator)
        image = else_system_administrator.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, image)
        project = else_system_administrator.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, project_image)
      end

      it 'denies access if employee system_administrator CUD manager image' do
        manager = FactoryBot.create(:employee, :manager)
        image = manager.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, image)
        project = manager.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, project_image)
      end

      it 'denies access if employee system_administrator CUD team_lead image' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        image = team_lead.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, image)
        project = team_lead.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, project_image)
      end

      it 'denies access if employee system_administrator CUD admin image' do
        admin = FactoryBot.create(:employee, :admin)
        image = admin.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, image)
        project = admin.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, project_image)
      end
    end

    describe 'manager CUD employee image' do
      it 'denies access if employee manager CUD other image' do
        other = FactoryBot.create(:employee, :other)
        image = other.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, image)
        project = other.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, project_image)
      end

      it 'grants access if employee manager CUD developer image' do
        developer = FactoryBot.create(:employee, :developer)
        image = developer.create_image(image: 'test.png')
        expect(subject).to permit(manager, image)
        project = developer.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(manager, project_image)
      end

      it 'denies access if employee manager CUD system_administrator image' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        image = system_administrator.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, image)
        project = system_administrator.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, project_image)
      end

      it 'grants access if employee manager CUD his image' do
        image = manager.create_image(image: 'test.png')
        expect(subject).to permit(manager, image)
        project = manager.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(manager, project_image)
      end

      it 'denies access if employee manager CUD else manager image' do
        else_manager = FactoryBot.create(:employee, :manager)
        image = else_manager.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, image)
        project = else_manager.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, project_image)
      end

      it 'denies access if employee manager CUD team_lead image' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        image = team_lead.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, image)
        project = team_lead.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, project_image)
      end

      it 'denies access if employee manager CUD admin image' do
        admin = FactoryBot.create(:employee, :admin)
        image = admin.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, image)
        project = admin.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, project_image)
      end
    end

    describe 'team_lead CUD employee image' do
      it 'denies access if employee team_lead CUD other image' do
        other = FactoryBot.create(:employee, :other)
        image = other.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, image)
        project = other.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, project_image)
      end

      it 'grants access if employee team_lead CUD his department developer image' do
        team_lead = FactoryBot.create(:employee, :team_lead, department: 'ruby')
        developer = FactoryBot.create(:employee, :developer, department: 'ruby')
        image = developer.create_image(image: 'test.png')
        expect(subject).to permit(team_lead, image)
        project = developer.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(team_lead, project_image)
      end

      it 'denies access if employee team_lead CUD not his department developer image' do
        team_lead = FactoryBot.create(:employee, :team_lead, department: 'ruby')
        developer = FactoryBot.create(:employee, :developer, department: 'js')
        image = developer.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, image)
        project = developer.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, project_image)
      end

      it 'denies access if employee team_lead CUD system_administrator image' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        image = system_administrator.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, image)
        project = system_administrator.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, project_image)
      end

      it 'denies access if employee team_lead CUD manager image' do
        manager = FactoryBot.create(:employee, :manager)
        image = manager.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, image)
        project = manager.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, project_image)
      end

      it 'grants access if employee team_lead CUD his image' do
        image = team_lead.create_image(image: 'test.png')
        expect(subject).to permit(team_lead, image)
        project = team_lead.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(team_lead, project_image)
      end

      it 'denise access if employee team_lead CUD else team_lead image' do
        else_team_lead = FactoryBot.create(:employee, :team_lead)
        image = else_team_lead.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, image)
        project = else_team_lead.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, project_image)
      end

      it 'denies access if employee team_lead CUD admin image' do
        admin = FactoryBot.create(:employee, :admin)
        image = admin.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, image)
        project = admin.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, project_image)
      end
    end

    describe 'admin CUD employee image' do
      it 'grants access if employee admin CUD other image' do
        other = FactoryBot.create(:employee, :other)
        image = other.create_image(image: 'test.png')
        expect(subject).to permit(admin, image)
        project = other.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(admin, project_image)
      end

      it 'grants access if employee admin CUD developer image' do
        developer = FactoryBot.create(:employee, :developer)
        image = developer.create_image(image: 'test.png')
        expect(subject).to permit(admin, image)
        project = developer.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(admin, project_image)
      end

      it 'grants access if employee admin CUD system_administrator' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        image = developer.create_image(image: 'test.png')
        expect(subject).to permit(admin, image)
        project = system_administrator.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(admin, project_image)
      end

      it 'grants access if employee admin CUD manager image' do
        manager = FactoryBot.create(:employee, :manager)
        image = manager.create_image(image: 'test.png')
        expect(subject).to permit(admin, image)
        project = manager.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(admin, project_image)
      end

      it 'grants access if employee admin CUD team_lead image' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        image = team_lead.create_image(image: 'test.png')
        expect(subject).to permit(admin, image)
        project = team_lead.projects.create(name: 'test_project')
        project_image = project.create_image(image: 'test.png')
        expect(subject).to permit(admin, project_image)
      end

      it 'grants access if employee admin CUD his image' do
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
