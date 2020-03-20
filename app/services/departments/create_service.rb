# frozen_string_literal: true

module Departments
  class CreateService < ApplicationService
    # @attr_reader params [Hash]:
    # - name: [String]
    # - team_lead_id: [Integer] (optional)

    def call
      Department.create!(params)
    end
  end
end
