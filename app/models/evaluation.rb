class Evaluation < ApplicationRecord
  belongs_to :user
  belongs_to :saler, class_name: "User"
  belongs_to :buyer, class_name: "User"

  with_options presence: true do
    validates :user_id
    validates :saler_id
    validates :buyer_id
    validates :evaluation
  end
end
