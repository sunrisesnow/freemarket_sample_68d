class Point < ApplicationRecord
  belongs_to :user
  with_options presence: true do
    validates :user_id
    validates :point
  end
end
