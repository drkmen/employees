# frozen_string_literal: true
# scope :role, -> (role) { where role: role }
# scope :office, -> (office) { where office: office }
# scope :department, -> (department) { where department: department }
require 'rails_helper'

RSpec.describe Project, type: :model do

  before do
    Employee.new(first_name: 'qwe', last_name: 'qweqwe', email: 'email@gmail.com', password: '12345678').save
    Employee.new(first_name: '2qwe', last_name: '2qweqwe', email: '2email@gmail.com', password: '12345678').save
  end

  describe 'scope tests' do
    it 'default scope test' do
      expect(Employee.all.size).to be(2)
      expect(Employee.deleted.size).to be(0)
    end

    it 'delete method test' do
      Employee.last.delete
      expect(Employee.all.size).to be(1)
      expect(Employee.deleted.size).to be(1)
    end

    it 'restore method test' do
      Employee.last.delete
      Employee.deleted.last.restore
      expect(Employee.all.size).to be(2)
      expect(Employee.deleted.size).to be(0)
    end

  end

end
