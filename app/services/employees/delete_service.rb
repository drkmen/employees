# frozen_string_literal: true

module Employees
  class DeleteService < ApplicationService
    # @attr_reader params [Hash]:
    # - employee: [Employee]

    def call
      raise ArgumentError, '`employee` is missing' unless employee

      employee.delete!
    end

    private

    def employee
      params[:employee].presence
    end
  end
end
