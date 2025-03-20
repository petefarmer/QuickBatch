module Admin
  class PriceGroupsController < ApplicationController
    before_action :set_price_group, only: [:show, :edit, :update, :destroy]

    def index
      @price_groups = PriceGroup.all
    end

    def show
    end

    def new
      @price_group = PriceGroup.new
    end

    def edit
    end

    def create
      @price_group = PriceGroup.new(price_group_params)

      if @price_group.save
        redirect_to admin_price_groups_path, notice: 'Price group was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @price_group.update(price_group_params)
        redirect_to admin_price_groups_path, notice: 'Price group was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @price_group.destroy
      redirect_to admin_price_groups_path, notice: 'Price group was successfully deleted.'
    end

    private

    def set_price_group
      @price_group = PriceGroup.find(params[:id])
    end

    def price_group_params
      params.require(:price_group).permit(:name, :description)
    end
  end
end
