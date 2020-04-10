# frozen_string_literal: true

class Office < ApplicationRecord
  has_many :employees
  belongs_to :department, optional: true

  validates_presence_of :name
end
