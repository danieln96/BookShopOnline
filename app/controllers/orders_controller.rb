class OrdersController < ApplicationController
    before_action :require_address, only: [:edit]
   def new
    if logged_in?
        if Order.exists?(:user_id => "#{current_user.id}", :status => "Koszyk")
            session[:order_id] = Order.find_by(user_id: "#{current_user.id}", status: "Koszyk").id
        else
            @order = Order.new(user_id: current_user.id, status:"Koszyk", total: 0)
            if @order.save
                session[:order_id] = @order.id
            end
        end
        redirect_to root_path
    end
   end
   def edit
       if current_user.id != Order.find_by(id: session[:order_id]).user_id
          flash[:danger] = "To nie twoje zamówienie"
          redirect_to root_path
       else
          @order = Order.find_by(id: session[:order_id])
          @order.delivery_id = params[:delivery]
          @order.total = @order.total + Delivery.find(params[:delivery]).price.to_f
          @items = OrderItem.where(order_id: session[:order_id])
          @items.each do |item|
             @book = Book.find_by(id: item.order_id)
             @book.copies = @book.copies - item.quantity
             @book.save
          end
          @order.status = "Do zapłaty"
          @order.save
          flash[:success] = "Złożono zamówienie"
          redirect_to new_order_path
       end
   end
   def index
      if Order.exists?(:user_id => "#{current_user.id}", :status => ["Realizowanie","Wysłano"])
          
      else
          
      end
   end
   def update
       
   end
   def destroy
       
   end
   def show
       @deliveries = Delivery.all
       if current_user.id != Order.find_by(id: session[:order_id]).user_id
          flash[:danger] = "To nie twoje zamówienie"
          redirect_to root_path
       else
           @order_items = OrderItem.search(session[:order_id])
           tot = 0
           @order_items.each do |item|
               tot = Book.find_by(id: item.book_id).price*item.quantity + tot
           end
           @order = Order.find_by(session[:order_id])
           @order.total = tot
           @order.save
       end
   end
   private
   def require_address
      if Address.exists?(:user_id => "#{current_user.id}") 
          
      else
          flash[:danger] = "Musisz dodać adres do swojego konta."
          redirect_to addresses_path
      end
   end
end