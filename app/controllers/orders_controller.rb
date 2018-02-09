class OrdersController < ApplicationController
    require 'date'
    before_action :require_address, only: [:edit]
    before_action :require_admin, only: [:paymentorder, :shipmentorder, :adminorders, :showorderitems]
           #caches_page :showorderitems
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
          @items = OrderItem.where("order_id = #{session[:order_id]}")
          @items.each do |item|
             @book = Book.find_by(id: item.book_id)
             @book.copies = @book.copies - item.quantity
             if @book.copies < 0 
                 flash[:danger] = "Nie możemy zrealizować tego zamówienia"
                 redirect_to order_path
             end
          end
          @items.each do |item|
             @book = Book.find_by(id: item.book_id)
             @book.copies = @book.copies - item.quantity
             @book.save
          end
          @order.status = "Do zapłaty"
          @order.save
          flash[:success] = "Złożono zamówienie."
          redirect_to new_order_path
       end
   end
   def index
       @orders = Order.where("user_id = #{current_user.id} AND status NOT LIKE 'Koszyk'")
   end
   def adminorders
       @orders = Order.where("status NOT LIKE 'Koszyk'").order("status ASC")
   end
   def paymentorder
      @order = Order.find(params[:id]) 
      @order.status = "Realizowanie"
      @order.save
      flash[:success] = "Zmieniono status"
      redirect_to adminorders_path
   end
   def shipmentorder
      @order = Order.find(params[:id]) 
      @order.status = "Wysłano"
      @order.save
      flash[:success] = "Zmieniono status"
      redirect_to adminorders_path
   end
   def showorderitems
       @order = Order.find(params[:id])
       @items = OrderItem.where("order_id = #{params[:id]}")
       @address = Address.find_by(user_id: @order.user_id)
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
           @order = Order.find_by(id: session[:order_id])
           @order.total = tot
           @order.save
       end
   end
    def download
        require "prawn"
        #require "prawn/tables"
        @order = Order.find(params[:id])
        @items = OrderItem.where("order_id = #{@order.id}")
        @address = Address.find_by(user_id: @order.user_id)
        if File.exists?("public/pdfs/faktura #{@order.id}.pdf")
            send_file "public/pdfs/faktura #{@order.id}.pdf", :type=>"application/pdf", :x_sendfile=>true
        else
            generate_pdf(@order, @items, @address)
            send_file "public/pdfs/faktura #{@order.id}.pdf", :type=>"application/pdf", :x_sendfile=>true
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
    def require_admin
        if logged_in? and !current_user.admin?
            flash[:danger] = "Tylko admin może zrobić coś takiego"
            redirect_to root_path
        end
    end
    def generate_pdf(order, items, address)
        books = Array.new
        total = 0
        items.each do |item|
            hash = Hash.new
           @book = Book.find(item.book_id)
           hash["title"] = @book.title
           hash["author"] = @book.author
           hash["publisher"] = @book.publisher
           hash["price"] = @book.price * item.quantity
           total += hash["price"]
           hash["quantity"] = item.quantity
           books << hash
        end
        total+= Delivery.find(order.delivery_id).price
        
        Prawn::Document.generate("public/pdfs/faktura #{order.id}.pdf") do
              font_families.update("Arial" => {
                :normal => "app/assets/fonts/Arial.ttf",
                :italic => "app/assets/fonts/Arial Italic.TTF",
              })
            font "Arial"

            # Defining the grid 
            # See http://prawn.majesticseacreature.com/manual.pdf
            define_grid(:columns => 5, :rows => 8, :gutter => 10) 
            
            grid([0,0], [1,1]).bounding_box do 
              text  "Faktura", :size => 18
              text "Faktura numer: #{order.id}", :align => :left
              text "Data: #{Date.today.to_s}", :align => :left
              move_down 10
              
              text "Nabywca "
              text "#{User.find(address.user_id).username}"
              text "telefon: #{address.telnumber}"
              text "email: #{User.find(address.user_id).email}"
            end
            
            grid([0,3.6], [1,4]).bounding_box do 
              # Company address
              #move_down 10
              text "BookShopOnline", :align => :left
              text "Adres", :align => :left
              text "Nowoursynowska 161", :align => :left
              text "02-787 Warszawa", :align => :left
              text "Lubelskie", :align => :left
              text "Tel No: 22312512123", :align => :left
            end
            
            text "Szczegóły faktury"#, :style => :arial
            stroke_horizontal_rule
            move_down 10
            items = [["No","Tytuł", "Autor", "Cena"]]
            items += books.each_with_index.map do |h, i|
              [
                i + 1,
                h["title"],
                h["author"],
                h["price"],
              ]
            end
            items += [["", "", "Przesyłka", "#{Delivery.find(order.delivery_id).price}"]]
            items += [["", "", "Razem", "#{total}"]]
            
            
            table items, :header => true, 
              :column_widths => { 0 => 50, 1 => 150,2 => 200, 3 => 100}, :row_colors => ["d2e3ed", "FFFFFF"] do
                style(columns(3)) {|x| x.align = :right }
              end
            move_down 40
            text "Sposób dostawy: #{Delivery.find(order.delivery_id).title}", :style => :italic
            
            move_down 20
            text "..............................."
            text "Podpis"
            
            move_down 10
            stroke_horizontal_rule
            
            bounding_box([bounds.right - 50, bounds.bottom], :width => 60, :height => 20) do
              pagecount = page_count
              text "Strona #{pagecount}"
            end

        end
    end
end