class Item < ApplicationRecord
  has_many :images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :messages, class_name: "Message" ,foreign_key: "room_id", dependent: :destroy
  belongs_to :category
  accepts_nested_attributes_for :images, allow_destroy: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_date
  belongs_to_active_hash :delivery_method
  belongs_to_active_hash :trading_status

  scope :desc,                 -> {order('created_at DESC')}
  scope :including,            -> {includes(:images)}
  scope :not_draft,            -> {including.where.not(trading_status_id: 4)}
  scope :trading_not,          -> {where.not(trading_status_id: 4..5)}
  scope :category,             -> (category_id)       {where(category_id: category_id)}
  scope :draft,                -> (saler_id)          {including.where(saler_id: saler_id).where(trading_status_id: 4)}
  scope :exhibition,           -> (saler_id)          {including.where(saler_id: saler_id).where(buyer_id: nil).trading_not}
  scope :exhibition_trading,   -> (saler_id)          {including.where(saler_id: saler_id).where.not(buyer_id: nil).trading_not}
  scope :exhibition_completed, -> (saler_id)          {including.where(saler_id: saler_id).where(trading_status_id: 5)}
  scope :bought,               -> (buyer_id)          {including.where(buyer_id: buyer_id).trading_not}
  scope :bought_completed,     -> (buyer_id)          {including.where(buyer_id: buyer_id).where(trading_status_id: 5)}
  
  # 入力必須のバリデーション
  with_options presence: true do
    validates :name
    validates :explanation
    validates :category_id
    validates :status_id
    validates :category_id
    validates :delivery_charge_flag
    validates :prefecture_id
    validates :delivery_date_id
    validates :delivery_method_id
    validates :price
  end

  # 販売価格の数値範囲のバリデーション
  validates :price, numericality: {greater_than_or_equal_to: 300}
  validates :price, numericality: {less_than: 10000000}
  belongs_to :category

  # 商品と通知のアソシエーション、商品にイイねした際に通知を作成するメソッド
  has_many :notifications, dependent: :destroy

  # 文字数のバリデーション
  validates :name, length: { maximum: 40 }
  validates :explanation, length: { maximum: 1000 }
end
