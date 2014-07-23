# This class renders the home page according to whether or not a user is already 
# logged in.
class HomeController < ApplicationController
  
  # GET /
  def home
    if @current_user
      dashboard
    else
      welcome
    end
  end
  
  # GET / with user logged in
  def dashboard
    render "dashboard"
  end
  
  # GET / without user logged in
  def welcome
    render "welcome"
  end
  
end
