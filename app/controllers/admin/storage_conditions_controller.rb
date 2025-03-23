class Admin::StorageConditionsController < ApplicationController
  before_action :set_storage_condition, only: [:show, :edit, :update, :destroy]

  def index
    @storage_conditions = StorageCondition.all
  end

  def show
  end

  def new
    @storage_condition = StorageCondition.new
  end

  def edit
  end

  def create
    @storage_condition = StorageCondition.new(storage_condition_params)

    if @storage_condition.save
      redirect_to admin_storage_conditions_path, notice: 'Storage condition was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @storage_condition.update(storage_condition_params)
      redirect_to admin_storage_conditions_path, notice: 'Storage condition was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @storage_condition.destroy
    redirect_to admin_storage_conditions_url, notice: 'Storage condition was successfully destroyed.'
  end

  private

  def set_storage_condition
    @storage_condition = StorageCondition.find(params[:id])
  end

  def storage_condition_params
    params.require(:storage_condition).permit(:name, :description)
  end
end
