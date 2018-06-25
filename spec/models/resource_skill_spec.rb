# frozen_string_literal: true

# ResourceSkill Model Spec
require 'rails_helper'

RSpec.describe ResourceSkill, type: :model do
  before(:each) do
    FactoryBot.create(:employee, :admin)
    FactoryBot.create(:project, employee_id: Employee.last.id)
    FactoryBot.create(:skill)
    @resource_skill1 = Project.last.resource_skills.create!(skill_id: Skill.last.id)
    @resource_skill2 = Employee.last.resource_skills.create!(skill_id: Skill.last.id)
  end

  it 'has_many resource_skills' do
    expect(Employee.last.reload.resource_skills.last).to eq(@resource_skill2)
  end

  it 'belongs_to employee' do
    expect(Project.last.reload.resource_skills.last).to eq(@resource_skill1)
  end

  it 'belongs_to employee' do
    expect(Skill.last.reload.resource_skills.last).to eq(@resource_skill2)
  end

end
