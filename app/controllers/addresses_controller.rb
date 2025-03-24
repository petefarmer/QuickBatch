class AddressesController < ApplicationController
  before_action :set_addressable
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  
  def index
    @addresses = @addressable.addresses
  end
  
  def show
  end
  
  def new
    @address = @addressable.addresses.build
  end
  
  def create
    @address = @addressable.addresses.build(address_params)
    
    if @address.save
      redirect_to [@addressable, @address], notice: 'Address was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @address.update(address_params)
      redirect_to [@addressable, @address], notice: 'Address was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @address.destroy
    redirect_to [@addressable, :addresses], notice: 'Address was successfully deleted.'
  end
  
  private
  
  def set_addressable
    @addressable = find_addressable
  end
  
  def set_address
    @address = @addressable.addresses.find(params[:id])
  end
  
  def find_addressable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
  
  def address_params
    params.require(:address).permit(
      :address_type, :country_code, :format_type,
      :street_address_1, :street_address_2, :city,
      :state_province, :postal_code, :attention,
      :company_name, :district, :subdivision,
      :building_name, :floor_number, :room_number,
      :post_office_box, :phone, :email,
      :is_default, :notes
    )
  end
end 