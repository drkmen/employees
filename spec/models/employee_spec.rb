# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employee, type: :model do
  let!(:manager) { create :employee, :manager }
  let!(:developer) { create :employee, :developer }
  let!(:employee_deleted) { create :employee, :deleted }
  let!(:skill) { create :skill }
  let!(:office) { create(:office) }
  let!(:department) { create(:department, name: 'ruby', uid: :ruby) }
  let(:image) { Image.new(image: Rails.root.join('app/assets/images/placeholder.png').open) }

  subject(:employee) { create(:employee, image: image) }

  describe 'columns' do
    %i[
      id first_name last_name main_skill description email phone office role additional
      created_at updated_at encrypted_password reset_password_token reset_password_sent_at
      remember_created_at sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip
      last_sign_in_ip skype department slug invitation_token invitation_created_at invitation_sent_at
      invitation_accepted_at invitation_limit invited_by_id invited_by_type deleted_at upwork
      status grant_admin_permissions office_id department_id
    ].each do |field|
      it { is_expected.to have_db_column(field) }
    end
  end

  describe 'constants' do
    describe 'FILTERS' do
      subject { described_class::FILTERS }

      it { is_expected.to eq %i[role office department status] }
    end

    describe 'ROLES' do
      subject { described_class::ROLES }

      it { is_expected.to eq %i[other developer manager team_lead admin system_administrator] }
    end

    describe 'STATUSES' do
      subject { described_class::STATUSES }

      it { is_expected.to eq %i[free partially_busy busy] }
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:office).counter_cache(true).optional(true) }
    it { is_expected.to belong_to(:department).counter_cache(true).optional(true) }
    it { is_expected.to have_one(:image).dependent(:destroy) }
    it do
      is_expected.to have_many(:developer_managers)
        .with_foreign_key(:developer_id)
        .class_name(:EmployeeManager)
    end
    it { is_expected.to have_many(:managers).through(:developer_managers).source(:manager) }
    it do
      is_expected.to have_many(:manager_developers)
        .with_foreign_key(:manager_id)
        .class_name(:EmployeeManager)
    end
    it { is_expected.to have_many(:developers).through(:manager_developers).source(:developer) }
    it { is_expected.to have_many(:own_skills).class_name(:Skill) }
    it { is_expected.to have_many(:projects).dependent(:destroy) }
    it { is_expected.to have_many(:resource_skills).dependent(:destroy) }
    it { is_expected.to have_many(:skills).through(:resource_skills) }

    it do
      is_expected.to have_many(:manager_active_projects)
        .conditions(active: true)
        .class_name(:Project)
        .dependent(:destroy)
        .with_foreign_key(:manager_id)
    end

    it do
      is_expected.to have_many(:active_projects)
        .conditions(active: true)
        .class_name(:Project)
        .dependent(:destroy)
    end
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:role) }
    it { expect(described_class.roles).to eq described_class::ROLES.map(&:to_s).map.with_index(0).to_a.to_h }

    it { is_expected.to define_enum_for(:status) }
    it { expect(described_class.statuses).to eq described_class::STATUSES.map(&:to_s).map.with_index(0).to_a.to_h }
  end

  describe 'scopes' do
    describe '.default_scope' do
      subject { described_class.default_scoped.to_a }

      it { is_expected.to eq described_class.where(deleted_at: nil).to_a }
    end

    describe '.deleted_at' do
      subject { described_class.deleted }

      it { is_expected.to eq described_class.unscoped.where.not(deleted_at: nil) }
    end

    Employee::FILTERS.each do |filter|
      let(:values) do
        {
          role: :developer,
          office: employee.office,
          department: employee.department,
          status: :free
        }
      end

      describe ".#{filter}" do
        subject { described_class.public_send(filter, values[filter]) }

        it { is_expected.to eq described_class.where(filter => values[filter]) }
      end
    end

    # scopes with departments are created dynamically using Department model
    # rspec is not allow to do the same even if call scope directly
    # Department.all.each do |department|
    #   scope "#{department.uid}_dep", ->() { where(department_id: department.id) }
    # end

    describe '.search' do
      let(:search_param) { employee.name }

      subject { described_class.search(search_param) }

      it { is_expected.to contain_exactly(*employee)}

      context 'when search param is missing' do
        let(:search_param) { nil }

        it { is_expected.to contain_exactly(*[employee, developer, manager])}
      end
    end
  end

  describe 'methods' do
    describe '#name' do
      subject { employee.name }

      it { is_expected.to eq "#{employee.first_name} #{employee.last_name}" }
    end

    describe '#delete!' do
      it 'deletes employee' do
        employee.delete!
        expect(employee.deleted_at).to_not be_nil
      end
    end

    describe '#restore!' do
      it 'restores employee' do
        employee.restore!
        expect(employee.deleted_at).to be_nil
      end
    end

    describe '#avatar' do
      subject { employee.avatar }

      it { is_expected.to eq "/uploads/image/image/#{image.id}/placeholder.png" }

      context 'when image is missing' do
        before do
          allow(employee).to receive(:image).and_return nil
        end

        it { is_expected.to eq 'user.png' }
      end
    end

    describe '#friendly_name' do
      subject { employee.friendly_name }

      it { is_expected.to eq employee.email.split('@').first.tr('.', '_') }
    end

    describe '.filter by first_name' do
      before do
        employee.skills << skill
      end

      subject { described_class.filter_skills(described_class.all, skill.name) }

      it { is_expected.to contain_exactly(*employee) }
    end
  end
end
