# frozen_string_literal: true

class Image < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :imageable, polymorphic: true
end
