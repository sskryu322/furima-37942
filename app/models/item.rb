class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :name, presence: true
  validates :content, presence: true
  validates :category_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }, format: { with: /\A[0-9]+\z/ }
  validates :quality_id, presence: true
  validates :shipping_charge_id, presence: true
  validates :shipment_source_id, presence: true
  validates :date_shipment_id, presence: true
  validates :image, presence: true
end
