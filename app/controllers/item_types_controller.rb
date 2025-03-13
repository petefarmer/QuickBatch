class ItemTypesController < ApplicationController
  before_action :set_item_type, only: [:show, :edit, :update, :destroy]

  def index
    @item_types = ItemType.all
  end

  def show
  end

  def new
    @item_type = ItemType.new
  end

  def edit
  end

  def create
    @item_type = ItemType.new(item_type_params)
    if @item_type.save
      redirect_to @item_type, notice: 'Item type was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @item_type.update(item_type_params)
      redirect_to @item_type, notice: 'Item type was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item_type.destroy
    redirect_to item_types_url, notice: 'Item type was successfully deleted.'
  end

  private

  def set_item_type
    @item_type = ItemType.find(params[:id])
  end

  def item_type_params
    params.require(:item_type).permit(:name, :description)
  end
end
