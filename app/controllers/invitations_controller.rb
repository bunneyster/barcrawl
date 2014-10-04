class InvitationsController < ApplicationController
  before_action :set_invitation, only: [:update, :destroy]
  before_action :bounce_if_logged_out
  
  # POST /invitations (Invite a user from friends list)
  def create
    @invitation = Invitation.new(invitation_params)
    @recipient = User.find(invitation_params[:recipient_id])
    @tour = Tour.find(invitation_params[:tour_id])
    
    @invitation.sender = @current_user
    
    respond_to do |format|
      if @invitation.save
        UserMailer.user_invitation_email(@invitation.sender,
                                         @recipient,
                                         @tour,
                                         root_url).deliver
        format.html { redirect_to @tour, notice: 'Successfully sent invitation!' }
      else
        format.html { redirect_to @tour, notice: 'Oh no! Could not join the tour.' }
      end
    end
  end
  
  # PATCH/PUT /invitations/1 ("Join" or "Leave" button on '/tours/1')
  # PATCH/PUT /invitations/1.json
  def update
    respond_to do |format|
      if @invitation.update(invitation_update_params)
        format.html { redirect_to @invitation.tour, notice: "Invitation status: #{invitation_update_params[:status]}" }
      else
        format.html { redirect_to @invitation.tour, notice: 'Something went wrong.' }
      end
    end
  end
  
  # DELETE /invitations/1 (TODO: Add view for rescinding invitations)
  def destroy
    @invitation.destroy
    respond_to do |format|
      format.html { redirect_to @invitation.tour, notice: 'Sucessfully deleted invitation.' }
    end
  end
  
  private
  
    def set_invitation
      @invitation = Invitation.find(params[:id])
    end
    
    def invitation_update_params
      params.require(:invitation).permit(:status)
    end
    
    def invitation_params
      params.require(:invitation).permit(:recipient_id, :tour_id)
    end
end
