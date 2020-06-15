class Card < ApplicationRecord
  belongs_to :user

  validates :user_id, :payjp_id, presence: true
end
