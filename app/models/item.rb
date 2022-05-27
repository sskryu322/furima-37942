class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :quality
  belongs_to :shipping_charge
  belongs_to :shipment_source
  belongs_to :date_shipment
  belongs_to :user
  has_one :purchase_record
  has_one_attached :image

  with_options presence: true do
    validates :name, length: { maximum: 40 }
    validates :content, length: { maximum: 1000 }
    validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                      format: { with: /\A[0-9]+\z/ }
    validates :quality_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :shipping_charge_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :shipment_source_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :date_shipment_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :image
  end
end
