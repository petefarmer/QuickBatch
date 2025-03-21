class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all
    if params[:search].present?
      @items = @items.where("item_key ILIKE ? OR upc_key ILIKE ? OR description ILIKE ?", 
        "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    end
  end

  def show
  end

  def new
    @item = Item.new
    @active_tab = "item-master"
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item, tab: params[:tab]), notice: 'Item was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to items_url, notice: 'Item was successfully deleted.'
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :item_key, :upc_key, :description, :item_type_id, 
      :item_subtype_id, :order_method_id, :price_group_id,
      :product_key_id, :commodity_key_id, :abc_key_id, :stock_unit
    )
  end
end
