module Admin
  class OrderMethodsController < ApplicationController
    before_action :set_order_method, only: [:edit, :update, :destroy]

    def index
      @order_methods = OrderMethod.all
    end

    def new
      @order_method = OrderMethod.new
    end

    def create
      @order_method = OrderMethod.new(order_method_params)
      if @order_method.save
        redirect_to admin_order_methods_path, notice: 'Order method was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @order_method.update(order_method_params)
        redirect_to admin_order_methods_path, notice: 'Order method was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @order_method.destroy
      redirect_to admin_order_methods_path, notice: 'Order method was successfully deleted.'
    end

    private

    def set_order_method
      @order_method = OrderMethod.find(params[:id])
    end

    def order_method_params
      params.require(:order_method).permit(:name, :description)
    end
  end
end
