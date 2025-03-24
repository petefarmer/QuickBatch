module Admin
  class AddressesController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin
    before_action :set_address, only: [:show, :edit, :update, :destroy]
    before_action :set_addressable_options, only: [:new, :create, :edit, :update]
    
    def index
      @addresses = Address.includes(:addressable).order(created_at: :desc)
    end
    
    def show
    end
    
    def new
      @address = Address.new
      @addressable_type = params[:addressable_type] || Address.addressable_types.first
      @addressable_options = @addressable_type.constantize.all
    end
    
    def edit
    end
    
    def create
      @address = Address.new(address_params)
      @addressable_type = @address.addressable_type
      @addressable_options = @addressable_type.constantize.all

      if @address.save
        redirect_to admin_address_path(@address), notice: 'Address was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end
    
    def update
      if @address.update(address_params)
        redirect_to admin_address_path(@address), notice: 'Address was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
    
    def destroy
      @address.destroy
      redirect_to admin_addresses_path, notice: 'Address was successfully deleted.'
    end
    
    def addressable_options
      type = params[:type]
      options = type.constantize.all.map { |record| { id: record.id, name: record.name } }
      render json: options
    end
    
    private
    
    def set_address
      @address = Address.find(params[:id])
    end
    
    def set_addressable_options
      @addressable_type = params[:addressable_type] || Address.addressable_types.first
      @addressable_options = @addressable_type.constantize.all
    end
    
    def address_params
      params.require(:address).permit(
        :addressable_type,
        :addressable_id,
        :address_type,
        :street_address_1,
        :street_address_2,
        :city,
        :state_province,
        :postal_code,
        :country_code,
        :attention,
        :company_name,
        :district,
        :subdivision,
        :building_name,
        :floor_number,
        :room_number,
        :post_office_box,
        :phone,
        :email,
        :is_default,
        :notes
      )
    end
    
    def require_admin
      unless current_user.admin?
        redirect_to root_path, alert: 'You are not authorized to access this area.'
      end
    end
  end
end 