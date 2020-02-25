# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Image, type: :model do
  describe 'columns' do
    %i[id image imageable_type imageable_id created_at updated_at].each do |field|
      it { is_expected.to have_db_column(field) }
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:imageable) }
  end
end
