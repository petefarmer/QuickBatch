class Admin::AutoLotIssueMethodsController < ApplicationController
  before_action :set_auto_lot_issue_method, only: [:show, :edit, :update, :destroy]

  def index
    @auto_lot_issue_methods = AutoLotIssueMethod.all
  end

  def show
  end

  def new
    @auto_lot_issue_method = AutoLotIssueMethod.new
  end

  def edit
  end

  def create
    @auto_lot_issue_method = AutoLotIssueMethod.new(auto_lot_issue_method_params)
    if @auto_lot_issue_method.save
      redirect_to admin_auto_lot_issue_methods_path, notice: 'Auto lot issue method was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @auto_lot_issue_method.update(auto_lot_issue_method_params)
      redirect_to admin_auto_lot_issue_methods_path, notice: 'Auto lot issue method was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @auto_lot_issue_method.destroy
    redirect_to admin_auto_lot_issue_methods_path, notice: 'Auto lot issue method was successfully deleted.'
  end

  private

  def set_auto_lot_issue_method
    @auto_lot_issue_method = AutoLotIssueMethod.find(params[:id])
  end

  def auto_lot_issue_method_params
    params.require(:auto_lot_issue_method).permit(:name, :description)
  end
end 