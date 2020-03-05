# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Office, type: :model do
  describe 'columns' do
    %i[id name department_id employees_count created_at updated_at].each do |field|
      it { is_expected.to have_db_column(field) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:employees) }
    it { is_expected.to belong_to(:department).optional(true) }
  end
end
