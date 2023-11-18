class ShippingAdressesController < ApplicationController

  def create
    @shipping_address = Shipping_adress.new(ShippingAdress_params)
    
  end
end
