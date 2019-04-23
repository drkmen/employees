# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:employee) do
    create :employee, email: 'darthmaul@impire.com', first_name: 'Darth', last_name: 'Maul',
           department: :ruby, status: :free, role: :developer, office: FactoryBot.create(:office)
  end
  let(:manager) { create :employee, :manager }
  let(:developer) { create :employee, :developer }
  let(:employee_deleted) { create :employee, :deleted }
  let(:skill) { create :skill }

  describe 'assosiations' do
    it 'has_one image' do
      expect(employee).to respond_to :image
      expect(employee.image).to be nil
      image = employee.create_image(image: '1234')
      expect(employee.reload.image).to eq image
    end

    it 'has_many skills' do
      expect(employee).to respond_to :skills
      expect(employee.skills.to_a).to eq []
      skill = employee.skills.create!(name: 'skill1')
      expect(employee.reload.skills).to eq [skill]
    end

    it 'has_many projects' do
      expect(employee).to respond_to :projects
      expect(employee.projects.to_a).to eq []
      project = employee.projects.create!(name: 'project')
      expect(employee.reload.projects).to eq [project]
    end

    it 'has_many active projects' do
      expect(employee).to respond_to :active_projects
      expect(employee.active_projects.to_a).to eq []
      a_project = employee.projects.create!(name: 'project', active: true)
      expect(employee.reload.active_projects).to eq [a_project]
    end

    it 'has_many manager_active_projects' do
      expect(employee).to respond_to :manager_active_projects
      expect(employee.manager_active_projects.to_a).to eq []
      a_project = employee.projects.create!(name: 'project', active: true)
      expect(employee.reload.active_projects).to eq [a_project]
    end

    context 'many-to-many developers vs managers' do
      it 'manager should has_many developers' do
        expect(manager).to respond_to :developers
        expect(manager.developers).to be_empty
        manager.developers << developer
        expect(manager.developers).to eq [developer]
      end

      it 'developer should has_many managers' do
        expect(developer).to respond_to :managers
        expect(developer.managers).to be_empty
        developer.managers << manager
        expect(developer.managers).to eq [manager]
      end
    end
  end

  describe 'scopes' do
    it 'default scope' do
      expect(Employee.all).to eq [employee]
    end

    it 'deleted' do
      expect(Employee.deleted).to eq [employee_deleted]
    end

    describe 'role, office, department, status, search scopes' do
      {
        role: :developer,
        # office: Office.all.sample.id, TODO: fix me
        department: :ruby,
        status: :free,
        search: 'Darth',
        search: 'Darth Maul'
      }.each do |scope, value|
        it "#{scope}" do
          expect(Employee.send(scope, value)).to eq [employee]
        end
      end
    end

    describe 'sorting scope' do

      before do
        FactoryBot.create(:employee, role: 1, department: 1)
        FactoryBot.create(:skill, name: 'API development', skill_type: 'other_skill')
        FactoryBot.create(:skill, name: 'AWS', skill_type: 'service')
        Employee.last.resource_skills.new(skill: Skill.first, level: 100).save!
        Employee.last.resource_skills.new(skill: Skill.last, level: 0).save!
      end

      it 'It\'s must have a sorted order' do
        expect(Employee.last.resource_skills.sorted(Employee.last.id)).to eq Employee.last.resource_skills.sort_by { |skill| skill.level }.reverse
      end
    end
  end

  describe 'methods' do
    it '#name' do
      expect(employee.name).to eq 'Darth Maul'
    end

    it '#delete' do
      employee.delete
      expect(employee.deleted).to be true
    end

    it '#restore' do
      employee_deleted.restore
      expect(employee_deleted.deleted).to be false
    end

    it '#avatar with default' do
      expect(employee.avatar).to eq 'user.png'
    end

    it '#avatar' do
      employee.image = Image.new(image: Rails.root.join('app/assets/images/placeholder.png').open)
      expect(employee.avatar).to eq "/uploads/image/image/#{Image.last.id}/placeholder.png"
    end

    it '#friendly_name' do
      expect(employee.friendly_name).to eq 'darthmaul'
    end

    it '#filter by first_name' do
      ResourceSkill.create(employee_id: employee.id, skill_id: skill.id)
      result = Employee.filter_skills(Employee.all, skill.name)
      expect(result).to eq [employee]
    end
  end

  describe 'enums' do
    let(:actual_roles) do
      {
        'other' => 0,
        'developer' => 1,
        'manager' => 2,
        'team_lead' => 3,
        'admin' => 4,
        'system_administrator' => 5
      }
    end

    let(:actual_departments) do
      {
        'ruby' => 0,
        'php' => 1,
        'js' => 2,
        'sys_admins' => 3,
        'managers' => 4,
        'other_department' => 5,
        'game_dev' => 6,
        'ios' => 7,
        'android' => 8,
        'markup' => 9,
        'java' => 10
      }
    end

    let(:actual_statuses) do
      {
        'free' => 0,
        'partially_busy' => 1,
        'busy' => 2
      }
    end

    context 'class methods' do
      it 'should respond to roles' do
        expect(Employee).to respond_to :roles
        expect(Employee.roles).to eq actual_roles
      end

      it 'should respond to departments' do
        expect(Employee).to respond_to :departments
        expect(Employee.departments).to eq actual_departments
      end

      it 'should respond to statuses' do
        expect(Employee).to respond_to :statuses
        expect(Employee.statuses).to eq actual_statuses
      end
    end

    context 'instance methods' do
      context 'role methods' do
        %i[other developer manager team_lead admin system_administrator].each do |method|
          it "should respond to #{method}? and #{method}!" do
            expect(employee).to respond_to "#{method}?"
            expect(employee).to respond_to "#{method}!"
          end
        end
      end

      context 'department methods' do
        %i[ruby php js sys_admins managers other_department game_dev ios android markup java].each do |method|
          it "should respond to #{method}? and #{method}!" do
            expect(employee).to respond_to "#{method}?"
            expect(employee).to respond_to "#{method}!"
          end
        end
      end

      context 'status methods' do
        %i[free partially_busy busy].each do |method|
          it "should respond to #{method}? and #{method}!" do
            expect(employee).to respond_to "#{method}?"
            expect(employee).to respond_to "#{method}!"
          end
        end
      end
    end
  end
end
