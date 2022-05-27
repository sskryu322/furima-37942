require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '商品購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    context '商品が購入できる場合' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@purchase_address).to be_valid
      end
      it 'building_nameは空でも保存できる' do
        @purchase_address.building_name = ''
        expect(@purchase_address).to be_valid
      end
    end

    context '商品が購入できない場合' do
      it 'postal_codeが空だと購入できない' do
        @purchase_address.postal_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank", "Postal code is invalid. Include hyphen(-)")
      end
      it 'postal_codeにハイフンがないと購入できない' do
        @purchase_address.postal_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'postal_codeは「3桁ハイフン4桁の数字7桁」でないと購入できない(ハイフンの場所が違う)' do
        @purchase_address.postal_code = '1-234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'postal_codeは「3桁ハイフン4桁の数字7桁」でないと購入できない(桁数が違う)' do
        @purchase_address.postal_code = '123-45678'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'postal_codeは全角数字では購入できない' do
        @purchase_address.postal_code = '１２３-４５６７'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'shipment_source_idがid:1「---」では購入できない' do
        @purchase_address.shipment_source_id = '1'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Shipment source can't be blank")
      end
      it 'municipalityが空だと購入できない' do
        @purchase_address.municipality = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'addressが空だと購入できない' do
        @purchase_address.address = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Address can't be blank")
      end
      it 'telephone_numberが空だと購入できない' do
        @purchase_address.telephone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Telephone number can't be blank")
      end
      it 'telephone_numberは9桁以下だと購入できない' do
        @purchase_address.telephone_number = '123456789'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Telephone number is invalid")
      end
      it 'telephone_numberは12桁以上だと購入できない' do
        @purchase_address.telephone_number = '123456789012'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Telephone number is invalid")
      end
      it 'telephone_numberにハイフンがあると購入できない' do
        @purchase_address.telephone_number = '123-4567-8901'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Telephone number is invalid")
      end
      it 'telephone_numberが全角だと購入できない' do
        @purchase_address.telephone_number = '０９０１２３４５６７８'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Telephone number is invalid")
      end
      it 'userが紐付いていないと購入できないこと' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと購入できないこと' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空だと購入できない' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end