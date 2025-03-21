class Admin::ProductKeysController < ApplicationController
  before_action :set_product_key, only: [:show, :edit, :update, :destroy]

  def index
    @product_keys = ProductKey.all
  end

  def show
  end

  def new
    @product_key = ProductKey.new
  end

  def edit
  end

  def create
    @product_key = ProductKey.new(product_key_params)

    if @product_key.save
      redirect_to admin_product_keys_path, notice: 'Product key was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product_key.update(product_key_params)
      redirect_to admin_product_keys_path, notice: 'Product key was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product_key.destroy
    redirect_to admin_product_keys_path, notice: 'Product key was successfully deleted.'
  end

  private

  def set_product_key
    @product_key = ProductKey.find(params[:id])
  end

  def product_key_params
    params.require(:product_key).permit(:name, :description)
  end
end 