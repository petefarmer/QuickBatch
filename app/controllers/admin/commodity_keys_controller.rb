class Admin::CommodityKeysController < ApplicationController
  before_action :set_commodity_key, only: [:show, :edit, :update, :destroy]

  def index
    @commodity_keys = CommodityKey.all
  end

  def show
  end

  def new
    @commodity_key = CommodityKey.new
  end

  def edit
  end

  def create
    @commodity_key = CommodityKey.new(commodity_key_params)

    if @commodity_key.save
      redirect_to admin_commodity_keys_path, notice: 'Commodity key was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @commodity_key.update(commodity_key_params)
      redirect_to admin_commodity_keys_path, notice: 'Commodity key was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @commodity_key.destroy
    redirect_to admin_commodity_keys_path, notice: 'Commodity key was successfully deleted.'
  end

  private

  def set_commodity_key
    @commodity_key = CommodityKey.find(params[:id])
  end

  def commodity_key_params
    params.require(:commodity_key).permit(:name, :description)
  end
end 