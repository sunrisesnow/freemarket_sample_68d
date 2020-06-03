class SalesPrice < ApplicationRecord
  belongs_to :user
  with_options presence: true do
    validates :price
    validates :user_id
  end
end
