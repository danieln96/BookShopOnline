class CategoriesController < ApplicationController
    before_action :require_admin, only: [:destroy, :edit, :update, :new, :create]
    before_action :set_category, only: [:edit, :update, :destroy, :show]
    def new
        @category = Category.new
    end
    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:success] = "Utworzono kategorię"
            redirect_to categories_path
        else
            render 'new'
        end
    end
    def edit
        #set_category
    end
    def update
        #set_category
        if @category.update(category_params)
            flash[:success] = "Edytowano kategorię"
            redirect_to categories_path
        else
            render 'edit'
        end
    end
    def destroy
        #set_category
        if @category.destroy
            flash[:danger] = "Usunięto kategorię"
            redirect_to categories_path
        else
            render 'edit'
        end
    end
    def show
        #set_category
    end
    def index
        @categories = Category.all
    end
    private
    def set_category
        @category = Category.find(params[:id])
    end
    def category_params
       params.require(:category).permit(:name)
    end
    def require_admin
        if !logged_in? || (logged_in? and !current_user.admin?)
            flash[:danger] = "Tylko admin może zrobić coś takiego"
            redirect_to root_path
        end
    end
end