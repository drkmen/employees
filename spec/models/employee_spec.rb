# frozen_string_literal: true

# Employee Model Spec
require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:employee) { create :employee, first_name: 'John', last_name: 'Wick', email: 'wick@gmail.com', password: '123456' }
  let(:employee_deleted) { create :employee, first_name: 'Joe', last_name: 'Doe', email: 'doe@gmail.com', password: '123456'}
  let(:skill) { create :skill}

  it 'has_one image' do
    image1 = employee.create_image(image: '1234')
    expect(employee.reload.image).to eq(image1)
  end

  it 'has_many skills' do
    skill1 = employee.skills.create!(name: 'skill1')
    skill2 = employee.skills.create!(name: 'skill2')
    expect(employee.reload.skills).to eq([skill1, skill2])
  end

  it 'has_many projects' do
    project1 = employee.projects.create!(name: 'skill1')
    project2 = employee.projects.create!(name: 'skill2')
    expect(employee.reload.projects).to eq([project1, project2])
  end

  describe 'scope tests' do
    it 'default scope' do
      expect(Employee.all).to eq [employee, employee_deleted]
      expect(Employee.deleted).to eq []
    end

    it 'deleted scope' do
      employee_deleted.delete
      expect(Employee.deleted).to eq [employee_deleted]
    end
  end

  describe 'methods' do
    it '#name method' do
      expect(employee.name).to eq 'John Wick'
    end

    it '#delete method' do
      employee.delete
      expect(employee.deleted).to be true
    end

    it '#restore method' do
      employee_deleted.restore
      expect(employee_deleted.deleted).to be false
    end

    it '#avatar method with default' do
      expect(employee.avatar).to eq 'user.png'
    end

    it '#avatar method' do
      employee.image = Image.new(image: Rails.root.join('app/assets/images/bw-test-user.png').open)
      expect(employee.avatar).to eq "/uploads/image/image/#{Image.last.id}/bw-test-user.png"
    end

    it '#friendly_name method' do
      expect(employee.friendly_name).to eq 'wick'
    end

    it '#filter method by first_name' do
      ResourceSkill.create(employee_id: employee.id, skill_id: skill.id)
      result = Employee.filter_skills(Employee.all, skill.name)
      expect(result).to eq [employee]
    end

    it '#search method by first_name' do
      result = Employee.search('John')
      expect(result).to eq [employee]
    end

    it '#search method by first_name & last_name' do
      result = Employee.search('Joe Doe')
      expect(result).to eq [employee_deleted]
    end
  end
end
