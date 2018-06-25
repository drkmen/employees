# frozen_string_literal: true

# Employees Helper Spec
require 'rails_helper'

RSpec.describe EmployeesHelper, type: :helper do
  let(:admin) { FactoryBot.create(:employee, :admin) }
  let(:developer) { FactoryBot.create(:employee, :developer) }

  it 'has access to the helper methods defined in the module' do
    expect(role(admin)).to eq('Owner')
  end
  it 'has access to the helper methods defined in the module' do
    expect(role(developer)).to eq('Developer')
  end
end
