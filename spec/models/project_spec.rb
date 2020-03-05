# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:admin) { create(:employee, :admin) }
  let(:skill) { create(:skill) }
  let(:image) { Image.new(image: Rails.root.join('app/assets/images/placeholder.png').open) }

  subject(:project) { create(:project, employee: admin, skills: [skill], image: image) }

  describe 'columns' do
    %i[
      id name start_date end_date description client employee_id
      created_at updated_at link active manager_id repository
    ].each do |field|
      it { is_expected.to have_db_column(field) }
    end
  end


  describe 'associations' do
    it { is_expected.to have_many(:resource_skills).dependent(:destroy) }
    it { is_expected.to have_many(:skills).through(:resource_skills) }
    it { is_expected.to belong_to(:employee) }
    it { is_expected.to belong_to(:developer).class_name('Employee').with_foreign_key(:employee_id) }
    it { is_expected.to belong_to(:manager).class_name('Employee').with_foreign_key(:manager_id).optional(true) }
    it { is_expected.to have_one(:image).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'callbacks' do
    describe 'after_save' do
      describe '#add_skills_to_employee' do
        it 'adds project skills to employee' do
          expect(project.employee.skills).to include(*project.skills)
        end
      end
    end
  end

  describe 'methods' do
    describe '#avatar' do
      subject { project.avatar }

      it { is_expected.to eq image.image_url }

      context 'when image is missing' do
        before { allow(project).to receive(:image).and_return(nil) }

        it { is_expected.to eq 'placeholder.png' }
      end
    end
  end
end
