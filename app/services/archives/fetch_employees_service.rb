# frozen_string_literal: true

module Archives
  class FetchEmployeesService < ApplicationService
    def call
      collection = employees_collection.order('deleted_at DESC').group_by { |m| m.deleted_at.year }
      collection.each do |key, value|
        collection[key] = value.group_by { |v| v.deleted_at.month }
      end
    end

    private

    def employees_collection
      Employee.deleted
    end
  end
end
