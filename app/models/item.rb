class Item < ApplicationRecord
  # belongs_to :buyer, class_name: User
  # belongs_to :saler, class_name: User
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  
  # 画像を1枚以上登録するバリデーション
  validate :require_any_image
  def require_any_image
    errors.add(:base, :no_image)
  end
  
  # 入力必須のバリデーション
  with_options presence: true do
    validates :name
    validates :explanation
    validates :status
    validates :delivery_charge_flag
    validates :prefectures
    validates :delivery_date
    validates :price
  end

  # 販売価格の上限のバリデーション
  validates :price, numericality: {greater_than_or_equal_to: 300}
  validates :price, numericality: {less_than: 10000000}
end
