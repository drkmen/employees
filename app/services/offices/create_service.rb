# frozen_string_literal: true

module Offices
  class CreateService < ApplicationService
    # @attr_reader params [Hash]:
    # - name: [String]
    # - department_id: [Integer] (optional)

    def call
      Office.create!(params)
    end
  end
end
