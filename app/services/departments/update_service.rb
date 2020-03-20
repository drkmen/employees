# frozen_string_literal: true

module Departments
  class UpdateService < ApplicationService
    # @attr_reader params [Hash]:
    # - department: [Department]
    # - name: [String]
    # - team_lead_id: [Integer] (optional)

    def call
      raise ArgumentError, '`department` is missing' unless department

      department.update_attributes!(department_params)
    end

    private

    def department
      params[:department].presence
    end

    def department_params
      params.except(:department)
    end
  end
end
