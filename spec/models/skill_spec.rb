# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Skill, type: :model do
  describe 'columns' do
    %i[id name skill_type employee_id created_at updated_at].each do |field|
      it { is_expected.to have_db_column(field) }
    end
  end

  describe 'constants' do
    describe 'TYPES' do
      subject { described_class::TYPES }

      it { is_expected.to eq %i[programming_language framework database library service other_skill] }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:resource_skills).dependent(:destroy) }
    it { is_expected.to have_many(:employees).through(:resource_skills) }
    it { is_expected.to have_many(:projects).through(:resource_skills) }
    it { is_expected.to belong_to(:employee).optional(true) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:skill_type) }
    it { expect(described_class.skill_types).to eq described_class::TYPES.map(&:to_s).map.with_index(0).to_a.to_h }
  end

  describe 'validates' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
