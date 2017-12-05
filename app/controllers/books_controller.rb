class BooksController < ApplicationController
   def index
       @books = Book.paginate(page: params[:page], per_page: 10)
   end
   def new
       @book = Book.new
   end
   def create
       @book = Book.new(book_param)
       if @book.save
          flash[:success] = "Książka została prawidłowo dodana"
          redirect_to books_path
       else
          render 'new'
       end
   end
   def show
       @book = Book.find(params[:id])
   end
   def edit
       @book = Book.find(params[:id])
   end
   def update
       @book = Book.find(params[:id])
       if @book.update(book_param)
          flash[:success] = "Pozycja została edytowana"
          redirect_to books_path
       else
          render 'edit'
       end
   end
   def destroy
       @book = Book.find(params[:id])
       if @book.destroy
         flash[:danger] = "Pozyzja została usunięta"
         redirect_to books_path
       else
          redirect_to books_path
       end     
   end
   private
   def book_param
      params.require(:book).permit(:title, :author, :publisher, :pdate, :isbn, :pages, :price, :copies)
   end
end