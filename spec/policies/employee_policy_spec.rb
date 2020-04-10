require 'rails_helper'

RSpec.describe EmployeePolicy do
  Employee::ROLES.each do |role|
    let(role) { FactoryBot.create(:employee, role.to_sym) }
  end

  let(:ruby_dep) { Department.create(name: 'ruby') }
  let(:js_dep) { Department.create(name: 'js') }

  subject { described_class }

  permissions :index? do
    context 'grants access for' do
      (adminable_roles + ['team_lead']).each do |role|
        it role do
          expect(subject).to permit(public_send(role))
        end
      end
    end

    context 'denies access for' do
      employee_roles.without('manager', 'team_lead', 'admin').each do |role|
        it role do
          expect(subject).to_not permit(public_send(role))
        end
      end
    end
  end

  permissions :show? do
    context 'grants access when' do
      it 'self employee' do
        expect(subject).to permit(developer, developer)
      end

      context 'role is' do
        adminable_roles.each do |role|
          it role do
            expect(subject).to permit(public_send(role), developer)
          end
        end

        context 'team_lead' do
          before do
            developer.update_attributes(department: team_lead.department)
          end

          it 'with same department' do
            expect(subject).to permit(team_lead, developer)
          end
        end
      end
    end

    context 'denies access for' do
      common_roles.without('team_lead').each do |role|
        it role do
          expect(subject).to_not permit(public_send(role))
        end
      end

      context 'team_lead' do
        it 'with different departments' do
          expect(subject).to_not permit(team_lead, developer)
        end
      end
    end
  end

  permissions :update? do
    context 'grants access when' do
      it 'self employee' do
        expect(subject).to permit(developer, developer)
      end

      context 'role is' do
        it 'admin' do
          expect(subject).to permit(admin, developer)
        end

        context 'manager' do
          it 'updating developer' do
            expect(subject).to permit(manager, developer)
          end

          it 'updating team_lead' do
            expect(subject).to permit(manager, team_lead)
          end
        end

        context 'team_lead' do
          before do
            developer.update_attributes(department: team_lead.department)
          end

          it 'with same department' do
            expect(subject).to permit(team_lead, developer)
          end
        end
      end
    end

    context 'denies access for' do
      common_roles.without('team_lead').each do |role|
        it role do
          expect(subject).to_not permit(public_send(role))
        end
      end

      context 'team_lead' do
        it 'with different departments' do
          expect(subject).to_not permit(team_lead, developer)
        end
      end
    end
  end

  permissions :destroy?, :restore? do
    context 'grants access for' do
      adminable_roles.each do |role|
        it role do
          expect(subject).to permit(public_send(role), developer)
        end
      end
    end

    context 'denies access for' do
      common_roles.each do |role|
        it role do
          expect(subject).to_not permit(public_send(role), developer)
        end
      end
    end
  end
end
