class Card < ApplicationRecord
  belongs_to :user

  scope :user, ->(user_id) {find_by(user_id: user_id)}
end
