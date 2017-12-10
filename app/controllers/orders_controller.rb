class OrdersController < ApplicationController
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
       
   end
   def update
       
   end
   def destroy
       
   end
   def show
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
end