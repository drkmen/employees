# frozen_string_literal: true

module Archives
  # @attr_reader params [Hash]:
  # - current_employee: [Employee] (Optional)

  class FetchEmployeesService < ApplicationService
    def call
      collection = employees_collection.order('deleted_at DESC').group_by { |m| m.deleted_at.year }
      collection.each do |key, value|
        collection[key] = value.group_by { |v| v.deleted_at.month }
      end
    end

    private

    def employees_collection
      collection = Employee.deleted
      collection = collection.where(department_id: current_employee.department_id) if team_lead_without_ap
      collection
    end

    def current_employee
      params[:current_employee].presence
    end

    def team_lead_without_ap
      current_employee&.team_lead? && !current_employee&.admin?
    end
  end
end
