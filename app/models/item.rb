class Item < ApplicationRecord
  belongs_to :user
  has_many :images
  has_many :categories
end
