class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :movie_to_index, only: :edit

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :content, :category_id, :condition_id, :charge_id, :area_id, :shipping_date_id,
                                 :price).merge(user_id: current_user.id)
  end

  def movie_to_index
    @item = Item.find(params[:id])
    return if @item.user == current_user

    redirect_to root_path
  end
end
