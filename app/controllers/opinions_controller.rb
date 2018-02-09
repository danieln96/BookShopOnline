class OpinionsController < ApplicationController
    def new
       @opinion  = Opinion.new 
    end
    def create
       @opinion = Opinion.new(opinion_param)
       
       if @opinion.save
           flash[:success] = "Opinia została dodana"
           redirect_to root_path
       else
           flash[:danger] = "Wystąpił błąd"
           redirect_to root_path
       end
    end
    def show
       @opinions = Opinion.where(book_id: @book.id) 
       @opinions = @opinions.paginate(page: params[:page], per_page: 3)
    end
    def index
        @opinions = Opinion.where(user_id: session[:user_id])
    end
    private
    def opinion_param
        params.require(:opinion).permit(:description, :rate, :book_id, :user_id) 
    end
end