# frozen_string_literal: true

module Departments
  class DestroyService < ApplicationService
    # @attr_reader params [Hash]:
    # - department: [Department]

    def call
      raise ArgumentError, '`department` is missing' unless department

      department.destroy
    end

    private

    def department
      params[:department].presence
    end
  end
end
