class InvitationsController < ApplicationController
  before_action :set_tour
  before_action :set_invitation, only: [:destroy]
  before_action :bounce_if_logged_out
  
  # POST /invitations ("Join" button on '/tours/1')
  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.user = @current_user
    
    respond_to do |format|
      if @invitation.save
        format.html { redirect_to @tour, notice: 'Successfully joined the tour!' }
      else
        format.html { redirect_to @tour, notice: 'Oh no! Could not join the tour.' }
      end
    end
  end
  
  # DELETE /invitations/1 ("Leave" button on '/tours/1')
  def destroy
    @invitation.destroy
    respond_to do |format|
      format.html { redirect_to @tour, notice: 'Sucessfully left the tour.' }
    end
  end
  
  private
  
    def set_tour
      @tour = Tour.find(invitation_params[:tour_id])
    end
  
    def set_invitation
      @invitation = Invitation.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def invitation_params
      params.require(:invitation).permit(:tour_id)
    end
end
