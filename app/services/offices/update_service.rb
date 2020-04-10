# frozen_string_literal: true

module Offices
  class UpdateService < ApplicationService
    # @attr_reader params [Hash]:
    # - office: [Office]
    # - name: [String]
    # - team_lead_id: [Integer] (optional)

    def call
      raise ArgumentError, '`office` is missing' unless office

      office.update_attributes!(office_params)
    end

    private

    def office
      params[:office].presence
    end

    def office_params
      params.except(:office)
    end
  end
end
