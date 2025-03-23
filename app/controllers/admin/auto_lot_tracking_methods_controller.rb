class Admin::AutoLotTrackingMethodsController < ApplicationController
  before_action :set_auto_lot_tracking_method, only: [:show, :edit, :update, :destroy]

  def index
    @auto_lot_tracking_methods = AutoLotTrackingMethod.all
  end

  def show
  end

  def new
    @auto_lot_tracking_method = AutoLotTrackingMethod.new
  end

  def edit
  end

  def create
    @auto_lot_tracking_method = AutoLotTrackingMethod.new(auto_lot_tracking_method_params)

    if @auto_lot_tracking_method.save
      redirect_to admin_auto_lot_tracking_methods_path, notice: 'Auto lot tracking method was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @auto_lot_tracking_method.update(auto_lot_tracking_method_params)
      redirect_to admin_auto_lot_tracking_methods_path, notice: 'Auto lot tracking method was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @auto_lot_tracking_method.destroy
    redirect_to admin_auto_lot_tracking_methods_url, notice: 'Auto lot tracking method was successfully destroyed.'
  end

  private

  def set_auto_lot_tracking_method
    @auto_lot_tracking_method = AutoLotTrackingMethod.find(params[:id])
  end

  def auto_lot_tracking_method_params
    params.require(:auto_lot_tracking_method).permit(:name, :description)
  end
end 