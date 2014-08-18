# This class handles logging in and logging out.
class SessionsController < ApplicationController
  
  # GET /
  def new
    # with user logged in
    if @current_user
      render "dashboard"
    # without user logged in
    else
      render "welcome"
    end
  end

  # POST / (login)
  def create
    user = User.find_by(email: session_params[:email])
    
    if user and user.authenticate(session_params[:password])
      # set :user_id field HERE, if account exists
      session[:user_id] = user.to_param
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
  
  private
  
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
