# This class handles logging in and logging out.
class SessionsController < ApplicationController
  
  # GET / handled by HomeController
  def new
  end

  # POST / (login)
  def create
    user = User.find_by(email: params[:email])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      # set_current_user
      flash[:alert] = "Welcome back #{user.name}!"
      redirect_to root_url
    else
      flash[:alert] = "Invalid email/password combination."
      redirect_to root_url
    end
  end

  # DELETE / (logout)
  def destroy
    session[:user_id] = nil
    flash[:alert] = "Logged out."
    redirect_to root_url
  end
end
