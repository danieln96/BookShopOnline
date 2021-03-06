class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show]
    before_action :require_same_user, only: [:edit, :update]
    before_action :require_admin, only: [:getadmin, :index, :destroy]
    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
    if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Witamy #{@user.username}!"
        redirect_to new_order_path
    else
       render 'new' 
    end
    end
   def edit
       
   end
   def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:danger] = "Użytkownik usunięty"
        redirect_to users_path
   end
   def update
       if @user.update(user_params)
        flash[:success] = "Konto #{@user.username} edytowane!"   
        else
           render 'edit' 
       end
   end
    def index
        @users = User.paginate(page: params[:page], per_page: 20)
    end
    def getadmin
        @user = User.find(params[:id])
        @user.admin = true
        @user.save
        flash[:success] = "Udało się"
        redirect_to users_path
    end
   private
   def user_params
      params.require(:user).permit(:username, :email, :password) 
   end
   def set_user
       @user = User.find(params[:id])
   end
   def require_same_user
    if current_user != @user
        flash[:danger] = "Możesz edytować tylko swoje konto"
        redirect_to root_path
    end
   end
    def require_admin
        if logged_in? and !current_user.admin?
            flash[:danger] = "Tylko admin może zrobić coś takiego"
            redirect_to root_path
        end
    end
end