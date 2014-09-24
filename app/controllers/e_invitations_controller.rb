class EInvitationsController < ApplicationController
  before_action :set_e_invitation, only: [:show, :edit, :update, :destroy]
  before_action :bounce_if_logged_out
  before_action :bounce_if_not_admin, only: [:index, :show, :update, :destroy]

  # GET /e_invitations/new
  def new
    @tour = Tour.find(params[:tour_id])
    @e_invitation = EInvitation.new(tour: @tour)
  end

  # POST /e_invitations
  # POST /e_invitations.json
  def create
    @guest = User.where(email: e_invitation_params[:recipient]).first
    @tour = Tour.find(e_invitation_params[:tour_id])
    if @guest
      # Submit email of someone with an existing user account
      @invitation = Invitation.new sender: @current_user,
                                   recipient: @guest,
                                   tour: @tour
    else
      # Submit email of someone without an existing user account
      @e_invitation = EInvitation.new(e_invitation_params)
      @e_invitation.sender = @current_user
    end


    respond_to do |format|
      if @e_invitation.save || @invitation.save
        UserMailer.invitation_email(@current_user.name,
                                    e_invitation_params[:recipient],
                                    @tour,
                                    root_url).deliver
        format.html { redirect_to @tour, notice: 'An invitation was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @e_invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /e_invitations/1
  # DELETE /e_invitations/1.json
  def destroy
    @e_invitation.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'E invitation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_e_invitation
      @e_invitation = EInvitation.find(params[:id])
    end

    def e_invitation_params
      params.require(:e_invitation).permit(:recipient, :tour_id)
    end
end
