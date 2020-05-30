class Account < ApplicationRecord
  mount_uploader :icon_image, ImageUploader
  mount_uploader :background_image, ImageUploader
  belongs_to :user
end
