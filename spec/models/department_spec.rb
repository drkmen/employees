# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Department, type: :model do
  subject(:department) { create(:department) }

  describe 'columns' do
    %i[id name uid team_lead_id employees_count created_at updated_at].each do |field|
      it { is_expected.to have_db_column(field) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:offices) }
    it { is_expected.to have_many(:employees) }
    it { is_expected.to belong_to(:team_lead).class_name('Employee').optional(true) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_uniqueness_of(:uid) }
  end

  describe 'callbacks' do
    describe 'before_save' do
      describe '#set_uid' do
        it 'sets uid' do
          expect(department.uid).to eq department.name.downcase
        end
      end
    end

    describe 'after_save' do
      describe '#set_team_lead' do
        let(:team_lead) { create(:employee, department: nil) }

        subject(:department) { create(:department, team_lead: team_lead) }

        it 'sets team lead' do
          subject
          expect(team_lead.reload.department).to eq department
        end
      end
    end
  end
end
