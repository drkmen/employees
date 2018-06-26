# frozen_string_literal: true
require 'addressable/uri'

# ApplicationHelper
module ApplicationHelper
  def link_to_with_filters(name = nil, path = nil, html_options = {}, &block)
    uri = Addressable::URI.new
    params.delete(:id)
    uri.query_values = params.permit(:office, :role, :department, :status)
    [*params[:skills]].each do |skill|
      uri.query += "&skills[]=#{skill}"
    end
    opts = path.is_a?(String) && uri.query.present? ? path + '?' + uri.query : path
    link_to name, opts, html_options
  end
end
