class Admin::TrackSerialLotsController < ApplicationController
  before_action :set_track_serial_lot, only: [:edit, :update, :destroy]

  def index
    @track_serial_lots = TrackSerialLot.all
  end

  def show
  end

  def new
    @track_serial_lot = TrackSerialLot.new
  end

  def edit
  end

  def create
    @track_serial_lot = TrackSerialLot.new(track_serial_lot_params)

    if @track_serial_lot.save
      redirect_to admin_track_serial_lots_path, notice: 'Track serial lot was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @track_serial_lot.update(track_serial_lot_params)
      redirect_to admin_track_serial_lots_path, notice: 'Track serial lot was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @track_serial_lot.destroy
    redirect_to admin_track_serial_lots_url, notice: 'Track serial lot was successfully destroyed.'
  end

  private

  def set_track_serial_lot
    @track_serial_lot = TrackSerialLot.find(params[:id])
  end

  def track_serial_lot_params
    params.require(:track_serial_lot).permit(:name, :description, :auto_lot_tracking_method_id)
  end
end
