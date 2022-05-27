class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create, :move_to_index]
  before_action :move_to_index, only: [:index, :create]

  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(:postal_code, :shipment_source_id, :municipality, :address, :building_name, :telephone_number).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']  # 自身のPAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price,              # 商品の値段
      card: purchase_params[:token],    # カードトークン
      currency: 'jpy'                   # 通貨の種類（日本円）
    )
  end

  def move_to_index
    redirect_to root_path if @item.purchase_record.present? || current_user.id == @item.user.id
  end
end
