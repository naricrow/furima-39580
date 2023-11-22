class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :unless_index, only: :index
  before_action :return_index, only: :index
  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @purchase_shipping_address = PurchaseShippingAddress.new
  end

  def create
    @purchase_shipping_address = PurchaseShippingAddress.new(purchase_params)
    if @purchase_shipping_address.valid?
       pay_item
       @purchase_shipping_address.save
       redirect_to root_path
    else
       gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
       render :index, status: :unprocessable_entity
    end
  end

  private
  
  def purchase_params
    params.require(:purchase_shipping_address,).permit(:post_code, :area_id, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key =ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def unless_index
    set_item  # before_action: :set_itemで呼び出すとエラーになるため、直接記述しました
    return unless @item.user == current_user

    redirect_to root_path
  end

  def return_index
    set_item
    return unless @item.purchase.present?

    redirect_to root_path
  end
end
