class Like < ApplicationRecord
  belongs_to :user
  belongs_to :item

  scope :users, ->(user_id) {where(user_id: user_id)}

  validates :user_id, presence: true
  validates :item_id, presence: true
  validates_uniqueness_of :item_id, scope: :user_id

  has_many :notifications, dependent: :destroy

  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      item_id: item.id,
      receiver_id: item.saler_id,
      action: "like"
    )
    notification.save
  end
end
