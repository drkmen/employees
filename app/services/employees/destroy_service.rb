# frozen_string_literal: true

module Employees
  class DestroyService < ApplicationService
    # @attr_reader params [Hash]:
    # - employee: [Employee]

    def call
      raise ArgumentError, 'Employee not found' unless employee

      employee.destroy!
    end

    private

    def employee
      params[:employee].presence
    end
  end
end
