class SessionsController < ApplicationController
def new 
    if logged_in?
        flash[:danger] = "Jesteś już zalogowany"
        redirect_to root_path
    end
end
def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        flash[:success] = "Zostałeś prawidłowo zalogowany"
        redirect_to new_order_path
    else
        flash.now[:danger] = "Podałeś błędne dane logowania"
        render 'new'
    end
end
def destroy
    session[:user_id] = nil
    session[:order_id] = nil
    flash[:success] = "Zostałeś wylogowany"
    redirect_to root_path
end
end