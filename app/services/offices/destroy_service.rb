# frozen_string_literal: true

module Offices
  class DestroyService < ApplicationService
    # @attr_reader params [Hash]:
    # - office: [Office]

    def call
      raise ArgumentError, '`office` is missing' unless office

      office.destroy
    end

    private

    def office
      params[:office].presence
    end
  end
end
