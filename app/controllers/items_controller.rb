class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all
    if params[:search].present?
      @items = @items.where("
        items.item_key ILIKE ? OR
        items.upc_key ILIKE ? OR
        items.description ILIKE ? OR
        items.stock_unit ILIKE ? OR
        items.production_unit ILIKE ? OR
        items.purchase_unit ILIKE ? OR
        items.sales_unit ILIKE ? OR
        items.item_type_id IN (
          SELECT id FROM item_types WHERE name ILIKE ?
        ) OR
        items.item_subtype_id IN (
          SELECT id FROM item_subtypes WHERE name ILIKE ?
        ) OR
        items.auto_lot_issue_method_id IN (
          SELECT id FROM auto_lot_issue_methods WHERE name ILIKE ?
        ) OR
        items.storage_condition_id IN (
          SELECT id FROM storage_conditions WHERE name ILIKE ?
        ) OR
        items.default_lot_size::text ILIKE ?
      ",
        "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%",
        "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%",
        "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%",
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
      :product_key_id, :commodity_key_id, :abc_key_id, :eccn_key_id, :track_serial_lot_id,
      :auto_lot_issue_method_id, :storage_condition_id, :default_lot_size,
      :stock_unit, :production_unit, :purchase_unit, :sales_unit,
      :height, :width, :length, :weight,
      :abc_key_name, :commodity_key_name, :eccn_key_name, :track_serial_lot_name,
      :physical_count_days, :manufacturer_code,
      :purchaseable, :saleable,
      :item_type_name, :item_subtype_name
    )
  end
end
