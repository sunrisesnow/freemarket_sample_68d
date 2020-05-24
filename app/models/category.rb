class Category < ApplicationRecord
  has_many :items
  has_ancestry
  has_many :items
end
