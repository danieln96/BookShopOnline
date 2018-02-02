class PagesController < ApplicationController
   def home
       @books = Book.last(3).reverse
   end
   def about
      
   end
end