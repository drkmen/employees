require 'rails_helper'

RSpec.describe Skill, type: :model do
  before do
    @other_skill = Skill.create(name: 'git', skill_type: 'other_skill')
    @programming_language_skill = Skill.create(name: 'javascript', skill_type: 'programming_language')
    @library_skill = Skill.create(name: 'jquery', skill_type: 'library')
    @framework_skill = Skill.create(name: 'angularjs', skill_type: 'framework')
    @database_skill = Skill.create(name: 'postgresql', skill_type: 'database')
  end

  describe 'enum skill_type' do
    it 'skill other_skill have correct skill_type value' do
      expect(@other_skill.other_skill?).to be(true)
      expect(@other_skill.framework?).to be(false)
    end

    it 'skill other_skill have correct skill_type value' do
      expect(@programming_language_skill.programming_language?).to be(true)
      expect(@programming_language_skill.framework?).to be(false)
    end

    it 'skill other_skill have correct skill_type value' do
      expect(@library_skill.library?).to be(true)
      expect(@library_skill.framework?).to be(false)
    end

    it 'skill other_skill have correct skill_type value' do
      expect(@framework_skill.framework?).to be(true)
      expect(@framework_skill.other_skill?).to be(false)
    end

    it 'skill other_skill have correct skill_type value' do
      expect(@database_skill.database?).to be(true)
      expect(@framework_skill.other_skill?).to be(false)
    end
  end
end
