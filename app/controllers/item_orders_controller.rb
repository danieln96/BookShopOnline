class ItemOrdersController < ApplicationController
    before_action :require_user_and_order
   def create
        if OrderItem.exists?(:book_id => "#{params[:book]}", :order_id => "#{session[:order_id]}")
            @item = OrderItem.find_by(book_id: "#{params[:book]}", order_id: "#{session[:order_id]}")
            @item.quantity = @item.quantity + params[:quantities].to_i
            if @item.quantity < Book.find_by(id: params[:book]).copies
                @item.save
                flash[:success] = "Dodano do koszyka"
            else
                flash[:danger] = "Za dużo egzemplarzy"
            end
            redirect_to books_path
        else
           @item = OrderItem.new(book_id: params[:book], quantity: params[:quantities], order_id: session[:order_id])
           @item.save
           flash[:success] = "Dodano do koszyka"
           redirect_to books_path
        end
   end
   def edit
       if OrderItem.exists?(:book_id => "#{params[:book]}", :order_id => "#{session[:order_id]}")
            @item = OrderItem.find_by(book_id: "#{params[:book]}", order_id: "#{session[:order_id]}")
            @item.quantity = params[:quantities].to_i
            @item.save
            flash[:success] = "Edytowano"
            redirect_to  order_path(session[:order_id])
       else
        flash[:danger] = "Coś nie działa"
        redirect_to  order_path(session[:order_id])
       end
   end
   def destroy
           @item = OrderItem.find_by(id: params[:id])
           if @item.destroy
               flash[:danger] = "usunięto jeden przedmiot"
               redirect_to order_path
           end
   end
   private
   def require_user_and_order
       if logged_in? and session[:order_id]
           
       else
           flash[:danger] = "Nie masz prawa"
           redirect_to root_path
       end
   end
end