class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: [:show, :edit, :update, :destroy]

  def index
    @purchase_orders = PurchaseOrder.all
    if params[:search].present?
      @purchase_orders = @purchase_orders.where("purchase_order_number ILIKE ? OR order_type ILIKE ?", 
        "%#{params[:search]}%", "%#{params[:search]}%")
    end
  end

  def show
  end

  def new
    @purchase_order = PurchaseOrder.new
  end

  def edit
  end

  def create
    @purchase_order = PurchaseOrder.new(purchase_order_params)

    if @purchase_order.save
      redirect_to @purchase_order, notice: 'Purchase order was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @purchase_order.update(purchase_order_params)
      redirect_to @purchase_order, notice: 'Purchase order was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @purchase_order.destroy
    redirect_to purchase_orders_url, notice: 'Purchase order was successfully deleted.'
  end

  private

  def set_purchase_order
    @purchase_order = PurchaseOrder.find(params[:id])
  end

  def purchase_order_params
    params.require(:purchase_order).permit(:purchase_order_number, :order_type)
  end
end
