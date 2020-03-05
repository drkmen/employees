# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmployeeManager, type: :model do
  describe 'columns' do
    %i[id developer_id manager_id created_at updated_at].each do |field|
      it { is_expected.to have_db_column(field) }
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:developer).with_foreign_key(:developer_id).class_name('Employee') }
    it { is_expected.to belong_to(:manager).with_foreign_key(:manager_id).class_name('Employee') }
  end
end
