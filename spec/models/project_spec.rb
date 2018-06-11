# frozen_string_literal: true

# Employee Model Spec
require 'rails_helper'

RSpec.describe Project, type: :model do

  before do
    FactoryBot.create(:employee, :admin_full)
    FactoryBot.create(:project, employee_id: Employee.last.id)
    FactoryBot.create(:skill)
  end

  it 'has_many resource_skills' do
    resource_skill1 = Project.last.resource_skills.create!(skill_id: Skill.last.id)
    resource_skill2 = Project.last.resource_skills.create!(skill_id: Skill.last.id)
    expect(Project.last.reload.resource_skills).to eq([resource_skill1, resource_skill2])
  end

  it 'has_one image' do
    image1 = Project.last.create_image(image: '1234')
    image2 = Project.last.create_image(image: '123456')
    expect(Project.last.reload.image).to eq(image2)
  end


  it 'has_many skills' do
    skill1 = Project.last.skills.create!(name: 'skill1')
    skill2 = Project.last.skills.create!(name: 'skill2')
    expect(Project.last.reload.skills).to eq([skill1, skill2])
  end

  it 'should validate presence of name' do
    record = Project.new
    record.name = '' # invalid state
    record.employee_id = Employee.last.id
    record.valid? # run validations
    expect(record).to be_invalid

    record.name = 'foobar' # valid state
    record.valid? # run validations
    expect(record).to be_valid
  end

  it 'belongs_to employee' do
    expect(Project.last.reload.employee).to eq(Employee.last)
  end

end
