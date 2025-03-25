class SalesOrdersController < ApplicationController
  before_action :set_sales_order, only: [:show, :edit, :update, :destroy]

  def index
    @sales_orders = SalesOrder.all
    if params[:search].present?
      @sales_orders = @sales_orders.where("sales_order_number ILIKE ? OR order_type ILIKE ?", 
        "%#{params[:search]}%", "%#{params[:search]}%")
    end
  end

  def show
  end

  def new
    @sales_order = SalesOrder.new
  end

  def edit
  end

  def create
    @sales_order = SalesOrder.new(sales_order_params)

    if @sales_order.save
      redirect_to @sales_order, notice: 'Sales order was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @sales_order.update(sales_order_params)
      redirect_to @sales_order, notice: 'Sales order was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sales_order.destroy
    redirect_to sales_orders_url, notice: 'Sales order was successfully deleted.'
  end

  private

  def set_sales_order
    @sales_order = SalesOrder.find(params[:id])
  end

  def sales_order_params
    params.require(:sales_order).permit(:sales_order_number, :order_type, :customer_id, :price, :quantity)
  end
end
