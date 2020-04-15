# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, unique: true|
|email|string|null: false, unique: true|
|password|string|null: false, unique: true|
|password_confirm|string|null, false|
|last_name|string|null: false, /\A[ぁ-んァ-ン一-龥]/|
|first_name|string|null: false, /\A[ぁ-んァ-ン一-龥]/|
|last_name_kana|string|null: false, /\A[ァ-ヶー－]+\z/|
|first_name_kana|string|null: false, /\A[ァ-ヶー－]+\z/|
|birthday|date|null: false|
|icon_image|string|-------|

### Association
- has_many :saling_items, -> { where(buyer_id is NULL) }, foreign_key: saler_id,     class_name: item
- has_many :sold_items, -> { where(buyer_id is not NULL) }, foreign_key: saler_id, class_name: item
- has_many :buyed_items, foreign_key: buyer_id, class_name: Item
- has_many :likes
- has_many :comments
- has_one  :address
- has_one  :creadit_cards

##  addressテーブル
|last_name|string|null: false,  /\A[ぁ-んァ-ン一-龥]/|
|first_name|string|null: false,  /\A[ぁ-んァ-ン一-龥]/|
|last_name_kana|string|null: false, /\A[ァ-ヶー－]+\z/|
|first_name_kana|string|null: false, /\A[ァ-ヶー－]+\z/|
|postal_code|string|null: false, /\A\d{7}\z/|
|prefectures|integer|null: false|
|municipality|string|null: false|
|address|stringr|null: false|
|building|string|-----|
|phone_number|string|/\A\d{10,11}\z/|

### Association
- belongs_to :user, optional: true

## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|buyer_id|integer|foreign_key: true|
|saler_id|integer|foreign_key: true, null: false|
|category_id|integer|null: false, foreign_key: true|
|brand_id|integer|foreign_key: true|
|name|string|null: false|
|explaination|text|null, false|
|status|string|null: false|
|delivery_charge_flag|string|null: false|
|prefectures|string|null: false|
|delivery_data|string|null: fasle|
|price|integer|null: false|
|delivery_method|string|null: false|

### Association
- belongs_to :buyer, class_name: User
- belongs_to :saler, class_name: User
- belongs_to :category
- belongs_to :brand
- has_many   :likes
- has_many   :comment
- has_many   :images

##  imagesテーブル

|Column|Type|Options|
|------|----|-------|
|item_id|integer|null: false, foreign_key: true|
|image|string|null: false|

### Association

- belongs_to  :item

## categorysテーブル

|Column|Type|Options|
|------|----|-------|
|path|string|-----|
|name|string|null: false|

### Association

- has_many :items
- has_ancestry

## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
|text|text|null: false|

### Association

- belongs_to :user
- belongs_to :item

## likesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|

### Association

- belongs_to :user
- belongs_to :item

##  brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association

- has_many :items

## cardsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|card_id|string|null: false|
|customer_id|string|null: false|

### Association

- belongs_to :user
