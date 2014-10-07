module CurrentUser
  extend ActiveSupport::Concern
  
  private
  
    def set_current_user
      user_id = session[:user_id]
      @current_user = User.where(id: user_id).first
    end
    
    def bounce_if_logged_out
      unless @current_user
        redirect_to root_url, notice: 'Please log back in.'
      end
    end
    
    def bounce_if_not_admin
      if @current_user.nil?
        redirect_to root_url
      elsif !@current_user.admin?
        redirect_to root_url, notice: 'Sorry! You must be an admin to view this page.'
      end
    end
    
    def bounce_if_not_attending
      redirect_to root_url, notice: 'Join the tour to propose venues and leave comments!'
    end
    
end