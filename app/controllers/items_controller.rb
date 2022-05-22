class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :content, :category_id, :price, :quality_id, :shipping_charge_id, :shipment_source_id,
                                 :date_shipment_id, :user, :image).merge(user_id: current_user.id)
  end
end
