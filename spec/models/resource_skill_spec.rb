# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ResourceSkill, type: :model do
  describe 'columns' do
    %i[id level experience skill_id project_id employee_id created_at updated_at].each do |field|
      it { is_expected.to have_db_column(field) }
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:skill).optional(true) }
    it { is_expected.to belong_to(:project).optional(true) }
    it { is_expected.to belong_to(:employee).optional(true) }
  end

  describe 'validations' do
    it { is_expected.to allow_value(nil).for(:level) }
    it { is_expected.to allow_value(0).for(:level) }
    it { is_expected.to allow_value(100).for(:level) }
    it { is_expected.to_not allow_value(-1).for(:level) }
    it { is_expected.to_not allow_value(101).for(:level) }
  end

  describe 'scopes' do
    # TODO: make sure that scope is really needed
    describe '.sorted' do
      let(:employee) { create(:employee) }

      subject { described_class.sorted(employee.id) }

      it { is_expected.to eq described_class.where(employee_id: employee).sort_by { |rs| rs.level || 0 }.reverse }
    end
  end
end
