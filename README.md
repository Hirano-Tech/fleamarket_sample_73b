# fleamarket_sample_73b DB設計

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|user_img|string||
|family_name|string|null: false|
|family_name_kana|string|null: false|
|name|string|null: false|
|name_kana|string|null: false|
|nickname|string|null: false|
|gender|string||
|phone|integer||
|email|string|null: false|
|password|string|null: false|
|birthday|integer|null: false|


### Association
- has_many :comments, dependent: :destroy
- has_many :items, dependent: :destroy
- has_many :cards, dependent: :destroy
- has_one :address, dependent: :destroy
- has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
- has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "saler_id", class_name: "Item"
- has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "saler_id", class_name: "Item"


## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|

### Association
- belong_to :user


## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|family_name_deliver|string|null: false|
|name_deliver|string|null: false|
|postal_code|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|block|string|null: false|
|building|string||
|user_id|integer|null: false, foreign_key: true|

### Association
- belong_to :user


## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|content|text||
|item_id|integer|null: false, foreign_key: true|

### Association
- belong_to :user
- belong_to :item


## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|price|integer|null: false|
|product_description|text|null: false|
|size|string||
|brand|text||
|condition_id|integer|null: false|
|delivary_charge_id|integer|null: false|
|sender_id|integer|null: false|
|shipping_date_id|integer|null: false|
|category_id|integer|null: false, foreign_key: true|
|saler_id|integer||
|buyer_id|integer||

### Association
has_many :comments, dependent: :destroy
belong_to :user
belong_to :category
has_many :images, dependent: :destroy
accepts_nested_attributes_for :images, allow_destroy: true
extend ActiveHash::Associations::ActiveRecordExtensions
belongs_to_active_hash :condition
belongs_to_active_hash :delivary_charge
belongs_to_active_hash :sender
belongs_to_active_hash :shipping_date
belongs_to :saler, class_name: "User", optional: true
belongs_to :buyer, class_name: "User", optional: true



## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string||
|item_id|integer|null: false, foreign_key: true|

### Association
mount_uploader :image, ImageUploader
belongs_to :item


## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|integer|index: true|

### Association
has_many :items
has_ancestry