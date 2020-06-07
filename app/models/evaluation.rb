class Evaluation < ApplicationRecord
  belongs_to :user
  belongs_to :saler, class_name: "User"
  belongs_to :buyer, class_name: "User"

  validates :evaluation, presence: true
end
