class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :shipment_source_id, :municipality, :address, :building_name, :telephone_number,
                :purchase_record_id, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :shipment_source_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :telephone_number, format: { with: /\A[0-9]{10,11}\z/ }
    validates :municipality, :address, :user_id, :item_id, :token
  end

  def save
    purchase_record = PurchaseRecord.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(postal_code: postal_code, shipment_source_id: shipment_source_id, municipality: municipality,
                           address: address, building_name: building_name, telephone_number: telephone_number, purchase_record_id: purchase_record.id)
  end
end
