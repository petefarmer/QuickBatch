class Admin::ItemSubtypesController < ApplicationController
  before_action :set_item_subtype, only: [:show, :edit, :update, :destroy]

  def index
    @item_subtypes = ItemSubtype.all
  end

  def show
  end

  def new
    @item_subtype = ItemSubtype.new
  end

  def edit
  end

  def create
    @item_subtype = ItemSubtype.new(item_subtype_params)
    if @item_subtype.save
      redirect_to admin_item_subtype_path(@item_subtype), notice: 'Item subtype was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @item_subtype.update(item_subtype_params)
      redirect_to admin_item_subtype_path(@item_subtype), notice: 'Item subtype was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item_subtype.destroy
    redirect_to admin_item_subtypes_url, notice: 'Item subtype was successfully deleted.'
  end

  private

  def set_item_subtype
    @item_subtype = ItemSubtype.find(params[:id])
  end

  def item_subtype_params
    params.require(:item_subtype).permit(:name, :description)
  end
end 