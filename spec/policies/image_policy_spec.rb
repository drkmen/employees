require 'rails_helper'

RSpec.describe ImagePolicy do

  let(:other) { FactoryBot.create(:employee, :other) }
  let(:programmer) { FactoryBot.create(:employee, :programmer) }
  let(:system_administrator) { FactoryBot.create(:employee, :system_administrator) }
  let(:manager) { FactoryBot.create(:employee, :manager) }
  let(:team_lead) { FactoryBot.create(:employee, :team_lead) }
  let(:admin) { FactoryBot.create(:employee, :admin) }

  subject { described_class }

  permissions :create?, :update?, :destroy? do
    describe 'other CUD image' do
      it 'grants access if employee other CUD his image' do
        image = other.create_image(image: 'test.png')
        expect(subject).to permit(other, image)
      end

      it 'denies access if employee other CUD else other image' do
        else_other = FactoryBot.create(:employee, :other)
        image = else_other.create_image(image: 'test.png')
        expect(subject).not_to permit(other, image)
      end

      it 'denies access if employee other CUD programmer image' do
        programmer = FactoryBot.create(:employee, :programmer)
        image = programmer.create_image(image: 'test.png')
        expect(subject).not_to permit(other, image)
      end

      it 'denies access if employee other CUD system_administrator image' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        image = system_administrator.create_image(image: 'test.png')
        expect(subject).not_to permit(other, image)
      end

      it 'denies access if employee other CUD manager image' do
        manager = FactoryBot.create(:employee, :manager)
        image = manager.create_image(image: 'test.png')
        expect(subject).not_to permit(other, image)
      end

      it 'denies access if employee other CUD team_lead image' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        image = team_lead.create_image(image: 'test.png')
        expect(subject).not_to permit(other, image)
      end

      it 'denies access if employee other CUD admin image' do
        admin = FactoryBot.create(:employee, :admin)
        image = admin.create_image(image: 'test.png')
        expect(subject).not_to permit(other, image)
      end
    end

    describe 'programmer CUD image' do
      it 'denies access if employee programmer CUD other image' do
        other = FactoryBot.create(:employee, :other)
        image = other.create_image(image: 'test.png')
        expect(subject).not_to permit(programmer, image)
      end

      it 'grants access if employee programmer CUD his image' do
        image = programmer.create_image(image: 'test.png')
        expect(subject).to permit(programmer, image)
      end

      it 'denies access if employee programmer CUD else programmer image' do
        else_programmer = FactoryBot.create(:employee, :programmer)
        image = else_programmer.create_image(image: 'test.png')
        expect(subject).not_to permit(programmer, image)
      end

      it 'denies access if employee programmer CUD system_administrator image' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        image = system_administrator.create_image(image: 'test.png')
        expect(subject).not_to permit(programmer, image)
      end

      it 'denies access if employee programmer CUD manager image' do
        manager = FactoryBot.create(:employee, :manager)
        image = manager.create_image(image: 'test.png')
        expect(subject).not_to permit(programmer, image)
      end

      it 'denies access if employee programmer CUD team_lead image' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        image = team_lead.create_image(image: 'test.png')
        expect(subject).not_to permit(programmer, image)
      end

      it 'denies access if employee programmer CUD admin image' do
        admin = FactoryBot.create(:employee, :admin)
        image = admin.create_image(image: 'test.png')
        expect(subject).not_to permit(programmer, image)
      end
    end

    describe 'system_administrator CUD image' do
      it 'denies access if employee system_administrator CUD other image' do
        other = FactoryBot.create(:employee, :other)
        image = other.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, image)
      end

      it 'grants access if employee system_administrator CUD his image' do
        image = system_administrator.create_image(image: 'test.png')
        expect(subject).to permit(system_administrator, image)
      end

      it 'denies access if employee system_administrator CUD programmer image' do
        programmer = FactoryBot.create(:employee, :programmer)
        image = programmer.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, image)
      end

      it 'denies access if employee system_administrator CUD else system_administrator image' do
        else_system_administrator = FactoryBot.create(:employee, :system_administrator)
        image = else_system_administrator.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, image)
      end

      it 'denies access if employee system_administrator CUD manager image' do
        manager = FactoryBot.create(:employee, :manager)
        image = manager.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, image)
      end

      it 'denies access if employee system_administrator CUD team_lead image' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        image = team_lead.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, image)
      end

      it 'denies access if employee system_administrator CUD admin image' do
        admin = FactoryBot.create(:employee, :admin)
        image = admin.create_image(image: 'test.png')
        expect(subject).not_to permit(system_administrator, image)
      end
    end

    describe 'manager CUD image' do
      it 'denies access if employee manager CUD other image' do
        other = FactoryBot.create(:employee, :other)
        image = other.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, image)
      end

      it 'grants access if employee manager CUD programmer image' do
        programmer = FactoryBot.create(:employee, :programmer)
        image = programmer.create_image(image: 'test.png')
        expect(subject).to permit(manager, image)
      end

      it 'denies access if employee manager CUD system_administrator image' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        image = system_administrator.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, image)
      end

      it 'grants access if employee manager CUD his image' do
        image = manager.create_image(image: 'test.png')
        expect(subject).to permit(manager, image)
      end

      it 'denies access if employee manager CUD else manager image' do
        else_manager = FactoryBot.create(:employee, :manager)
        image = else_manager.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, image)
      end

      it 'denies access if employee manager CUD team_lead image' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        image = team_lead.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, image)
      end

      it 'denies access if employee manager CUD admin image' do
        admin = FactoryBot.create(:employee, :admin)
        image = admin.create_image(image: 'test.png')
        expect(subject).not_to permit(manager, image)
      end
    end

    describe 'team_lead CUD image' do
      it 'denies access if employee team_lead CUD other image' do
        other = FactoryBot.create(:employee, :other)
        image = other.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, image)
      end

      it 'grants access if employee team_lead CUD his department programmer image' do
        team_lead = FactoryBot.create(:employee, :team_lead, department: 'ruby')
        programmer = FactoryBot.create(:employee, :programmer, department: 'ruby')
        image = programmer.create_image(image: 'test.png')
        expect(subject).to permit(team_lead, image)
      end

      it 'denies access if employee team_lead CUD not his department programmer image' do
        team_lead = FactoryBot.create(:employee, :team_lead, department: 'ruby')
        programmer = FactoryBot.create(:employee, :programmer, department: 'js')
        image = programmer.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, image)
      end

      it 'denies access if employee team_lead CUD system_administrator image' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        image = system_administrator.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, image)
      end

      it 'denies access if employee team_lead CUD manager image' do
        manager = FactoryBot.create(:employee, :manager)
        image = manager.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, image)
      end

      it 'grants access if employee team_lead CUD his image' do
        image = team_lead.create_image(image: 'test.png')
        expect(subject).to permit(team_lead, image)
      end

      it 'denies access if employee team_lead CUD admin image' do
        admin = FactoryBot.create(:employee, :admin)
        image = admin.create_image(image: 'test.png')
        expect(subject).not_to permit(team_lead, image)
      end
    end

    describe 'admin CUD image' do
      it 'grants access if employee admin CUD other image' do
        other = FactoryBot.create(:employee, :other)
        image = other.create_image(image: 'test.png')
        expect(subject).to permit(admin, image)
      end

      it 'grants access if employee admin CUD programmer image' do
        programmer = FactoryBot.create(:employee, :programmer)
        image = programmer.create_image(image: 'test.png')
        expect(subject).to permit(admin, image)
      end

      it 'grants access if employee admin CUD system_administrator' do
        system_administrator = FactoryBot.create(:employee, :system_administrator)
        image = programmer.create_image(image: 'test.png')
        expect(subject).to permit(admin, image)
      end

      it 'grants access if employee admin CUD manager image' do
        manager = FactoryBot.create(:employee, :manager)
        image = manager.create_image(image: 'test.png')
        expect(subject).to permit(admin, image)
      end

      it 'grants access if employee admin CUD team_lead image' do
        team_lead = FactoryBot.create(:employee, :team_lead)
        image = team_lead.create_image(image: 'test.png')
        expect(subject).to permit(admin, image)
      end

      it 'grants access if employee admin CUD his image' do
        image = admin.create_image(image: 'test.png')
        expect(subject).to permit(admin, image)
      end
    end

    it 'denies access if not employee' do
      expect(subject).not_to permit
    end
  end
end
