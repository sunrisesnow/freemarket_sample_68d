class Account < ApplicationRecord
  mount_uploader :icon_image, ImageUploader
  mount_uploader :background_image, ImageUploader
  belongs_to :user

  scope :user, ->(user_id) {find_by(user_id: user_id)}

  validates :user_id, presence: true
end
