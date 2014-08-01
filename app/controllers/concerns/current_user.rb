module CurrentUser
  extend ActiveSupport::Concern
  
  private
  
    def set_current_user
      user_id = session[:user_id]
      @current_user = User.where(id: user_id).first
    end
    
    def bounce_if_logged_out
      redirect_to root_url unless @current_user
    end
end