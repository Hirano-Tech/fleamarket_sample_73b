class Item < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :category
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
end