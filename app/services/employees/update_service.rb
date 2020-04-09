# frozen_string_literal: true

module Employees
  class UpdateService < ApplicationService
    # @attr_reader params [Hash]:
    # - employee: [Department]
    # - employee_params: [Hash]
    #   - email: [String]
    #   - first_name: [String]
    #   - last_name: [String]
    #   - main_skill: [String] (optional)
    #   - description: [String] (optional)
    #   - phone: [String] (optional)
    #   - role: [Integer, String]
    #   - status: [Integer, String]
    #   - skype: [String] (optional)
    #   - upwork: [String] (optional)
    #   - grant_admin_permissions: [Boolean] (optional)
    #   - office_id: [Integer] (optional)
    #   - department_id: [Integer] (optional)
    #   - additional: [Hash]

    def call
      raise ArgumentError, '`employee` is missing' unless employee

      employee.additional = employee_params[:additional] || {}
      employee.update_attributes!(employee_params)
    end

    private

    def employee
      params[:employee].presence
    end

    def employee_params
      params[:employee_params].presence
    end
  end
end
