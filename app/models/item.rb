class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :quality
  belongs_to :shipping_charge
  belongs_to :shipment_source
  belongs_to :date_shipment
  belongs_to :user
  has_one_attached :image

  validates :name, presence: true, length: { maximum: 40 }
  validates :content, presence: true, length: { maximum: 1000 }
  validates :category_id, presence: true, numericality: { other_than: 1 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                    format: { with: /\A[0-9]+\z/ }
  validates :quality_id, presence: true, numericality: { other_than: 1 }
  validates :shipping_charge_id, presence: true, numericality: { other_than: 1 }
  validates :shipment_source_id, presence: true, numericality: { other_than: 1 }
  validates :date_shipment_id, presence: true, numericality: { other_than: 1 }
  validates :image, presence: true
end
