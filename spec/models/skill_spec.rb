# frozen_string_literal: true

# Skill Model Spec
require 'rails_helper'

RSpec.describe Skill, type: :model do

    let(:other_skill) { FactoryBot.create(:skill, name: 'git', skill_type: 'other_skill') }
    let(:programming_language_skill) { FactoryBot.create(:skill, name: 'javascript', skill_type: 'programming_language') }
    let(:library_skill) { FactoryBot.create(:skill, name: 'jquery', skill_type: 'library') }
    let(:framework_skill) { FactoryBot.create(:skill, name: 'angularjs', skill_type: 'framework') }
    let(:database_skill) { FactoryBot.create(:skill, name: 'postgresql', skill_type: 'database') }

  describe 'enum skill_type' do
    it 'skill other_skill have correct skill_type value' do
      expect(other_skill.other_skill?).to be(true)
      expect(other_skill.framework?).to be(false)
    end

    it 'skill other_skill have correct skill_type value' do
      expect(programming_language_skill.programming_language?).to be(true)
      expect(programming_language_skill.framework?).to be(false)
    end

    it 'skill other_skill have correct skill_type value' do
      expect(library_skill.library?).to be(true)
      expect(library_skill.framework?).to be(false)
    end

    it 'skill other_skill have correct skill_type value' do
      expect(framework_skill.framework?).to be(true)
      expect(framework_skill.other_skill?).to be(false)
    end

    it 'skill other_skill have correct skill_type value' do
      expect(database_skill.database?).to be(true)
      expect(framework_skill.other_skill?).to be(false)
    end
  end

  it 'should validate presence of name' do
    record = Skill.new
    record.name = ''
    record.valid?
    expect(record).to be_invalid

    record.name = 'foobar'
    record.valid?
    expect(record).to be_valid
  end

  context 'skill associations specs' do
    before(:each) do
      @employee1 = FactoryBot.create(:employee, :admin)
      @employee2 = FactoryBot.create(:employee, :admin)
      @project1 = FactoryBot.create(:project, employee_id: @employee1.id)
      @project2 = FactoryBot.create(:project, employee_id: @employee2.id)
      @skill = FactoryBot.create(:skill)
    end

    it 'has_many resource_skills' do
      project_resource_skill1 = @project1.resource_skills.create!(skill_id: @skill.id)
      project_resource_skill2 = @project2.resource_skills.create!(skill_id: @skill.id)
      expect(@skill.reload.resource_skills).to eq([project_resource_skill1, project_resource_skill2])
    end

    it 'has_many projects' do
      @project1.resource_skills.create!(skill_id: @skill.id)
      @project2.resource_skills.create!(skill_id: @skill.id)
      expect(@skill.reload.projects).to eq([@project1, @project2])
    end

    it 'has_many employees' do
      @employee1.resource_skills.create!(skill_id: @skill.id)
      @employee2.resource_skills.create!(skill_id: @skill.id)
      expect(@skill.reload.employees).to eq([@employee1, @employee2])
    end
  end
end
