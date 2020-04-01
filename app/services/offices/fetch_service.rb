# frozen_string_literal: true

module Offices
  class FetchService < ApplicationService
    # @attr_reader params [Hash]:
    # - office: [Office]

    def call
      raise NotImplementedError
    end
  end
end
