class DeliveriesController < ApplicationController
    before_action :set_delivery, except: [:new, :create, :index]
    before_action :require_admin, except: [:index, :show]
   def new
       @delivery = Delivery.new
   end
   def create
       @delivery = Delivery.new(delivery_param)
       if @delivery.save
           flash[:success] = "Sposób dostawy dodany"
           redirect_to deliveries_path
       else
           render 'new'
       end
   end
   def edit

   end
   def update
       if @delivery.update(delivery_param)
          flash[:success] = "Pozycja została edytowana"
          redirect_to deliveries_path
       else
          render 'edit'
       end
   end
   def destroy
       if @delivery.destroy
         flash[:danger] = "Pozyzja została usunięta"
       end
       redirect_to deliveries_path
   end
   def show
       
   end
   def index
       @deliveries = Delivery.all
   end
   private
   def delivery_param
       params.require(:delivery).permit(:title, :price)
   end
   def set_delivery
       @delivery = Delivery.find(params[:id])
   end
   def require_admin
        if !logged_in? || (logged_in? and !current_user.admin?)
            flash[:danger] = "Tylko admin może zrobić coś takiego"
            redirect_to root_path
        end
   end
end