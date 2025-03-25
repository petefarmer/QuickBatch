class Admin::EccnKeysController < ApplicationController
  before_action :set_eccn_key, only: [:show, :edit, :update, :destroy]

  def index
    @eccn_keys = EccnKey.all
  end

  def show
  end

  def new
    @eccn_key = EccnKey.new
  end

  def edit
  end

  def create
    @eccn_key = EccnKey.new(eccn_key_params)

    if @eccn_key.save
      redirect_to admin_eccn_keys_path, notice: 'ECCN Key was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @eccn_key.update(eccn_key_params)
      redirect_to admin_eccn_keys_path, notice: 'ECCN Key was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @eccn_key.destroy
    redirect_to admin_eccn_keys_path, notice: 'ECCN Key was successfully deleted.'
  end

  private

  def set_eccn_key
    @eccn_key = EccnKey.find(params[:id])
  end

  def eccn_key_params
    params.require(:eccn_key).permit(:name, :description)
  end
end 