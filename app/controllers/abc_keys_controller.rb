class AbcKeysController < ApplicationController
  before_action :set_abc_key, only: [:show, :edit, :update, :destroy]

  def index
    @abc_keys = AbcKey.all
  end

  def show
  end

  def new
    @abc_key = AbcKey.new
  end

  def edit
  end

  def create
    @abc_key = AbcKey.new(abc_key_params)

    if @abc_key.save
      redirect_to @abc_key, notice: 'ABC Key was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @abc_key.update(abc_key_params)
      redirect_to @abc_key, notice: 'ABC Key was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @abc_key.destroy
    redirect_to abc_keys_url, notice: 'ABC Key was successfully deleted.'
  end

  private

  def set_abc_key
    @abc_key = AbcKey.find(params[:id])
  end

  def abc_key_params
    params.require(:abc_key).permit(:name, :description)
  end
end 