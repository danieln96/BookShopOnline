class AddressesController < ApplicationController
    before_action :require_same_user, only: [:edit, :update, :show]
   def new
    @address = Address.new
   end
   def create
    @address = Address.new(address_params)
    @address.user = current_user
    if @address.save
        flash[:success] = "Adres został dodany"
        redirect_to addresses_path
    else
        render 'new'
    end
   end
   def show
    @address = Address.find_by_user_id(params[:id])
   end
   def edit
    @address = Address.find_by_user_id(params[:id])
   end
   def update
    @address = Address.find_by_user_id(params[:id])
    if @address.update(address_params)
        flash[:success] = 'Adres został edytowany'
        redirect_to addresses_path
    else
        render 'edit'
    end
   end
   def index
       if current_user
        redirect_to address_path(current_user)
       else
        flash[:danger] = "Musisz się zalogować"
        redirect_to login_path
       end
   end
   private
   def address_params
      params.require(:address).permit(:first_name, :last_name, :street, :homenumber, :apartnumber, :postalcode, :city, :telnumber) 
   end
   def require_same_user
       @address = Address.find_by_user_id(params[:id])
    if @address
        if current_user != @address.user
            flash[:danger] = "Możesz edytować tylko swój adres"
            redirect_to root_path
        end
    else
        flash[:danger] = "Musisz na sam wpierw dodać adres"
        redirect_to new_address_path(params[:id])
    end
   end
end