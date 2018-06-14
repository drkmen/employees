# frozen_string_literal: true

# Employees Helper Spec
require 'rails_helper'

RSpec.describe EmployeesHelper, type: :helper do
  let(:employee1) { FactoryBot.create(:employee, :admin_full) }
  let(:employee2) { FactoryBot.create(:employee, :developer) }

  it "has access to the helper methods defined in the module" do
    expect(role(employee1)).to eq('Owner')
  end
  it "has access to the helper methods defined in the module" do
    expect(role(employee2)).to eq('Developer')
  end
end
