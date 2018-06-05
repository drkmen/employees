# frozen_string_literal: true

# scope :role, -> (role) { where role: role }
# scope :office, -> (office) { where office: office }
# scope :department, -> (department) { where department: department }
# scope :deleted, -> { unscoped.where(deleted: true) }
require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:employee) { create :employee, first_name: 'John', last_name: 'Wick', email: 'wick@gmail.com', password: '123456' }
  let(:employee_deleted) { create :employee, first_name: 'Joe', last_name: 'Doe', email: 'doe@gmail.com', password: '123456' }

  describe 'scope tests' do
    it 'default scope' do
      expect(Employee.all).to eq [employee, employee_deleted]
      expect(Employee.deleted).to eq []
    end

    it 'deleted scope' do
      employee_deleted.delete
      expect(Employee.deleted).to eq [employee_deleted]
    end
  end

  describe 'methods' do
    it '#name method' do
      expect(employee.name).to eq 'John Wick'
    end

    it '#delete method' do
      employee.delete
      expect(employee.deleted).to be true
    end

    it '#restore method' do
      employee_deleted.restore
      expect(employee_deleted.deleted).to be false
    end

    it '#search method by first_name' do
      result = Employee.search('John')
      expect(result).to eq [employee]
    end

    it '#search method by first_name & last_name' do
      result = Employee.search('Joe Doe')
      expect(result).to eq [employee_deleted]
    end
  end
end
