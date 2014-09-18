class EInvitationsController < ApplicationController
  before_action :set_e_invitation, only: [:show, :edit, :update, :destroy]
  before_action :bounce_if_logged_out
  before_action :bounce_if_not_admin, only: [:index, :show, :update, :destroy]

  # GET /e_invitations
  # GET /e_invitations.json
  def index
    @e_invitations = EInvitation.all
  end

  # GET /e_invitations/1
  # GET /e_invitations/1.json
  def show
  end

  # GET /e_invitations/new
  def new
    @e_invitation = EInvitation.new(tour: Tour.find(params[:tour_id]))
  end

  # POST /e_invitations
  # POST /e_invitations.json
  def create
    @e_invitation = EInvitation.new(e_invitation_params)
    @e_invitation.sender = @current_user

    respond_to do |format|
      if @e_invitation.save
        UserMailer.invitation_email(@e_invitation.sender.name,
                                    @e_invitation.recipient,
                                    @e_invitation.tour,
                                    root_url).deliver
        format.html { redirect_to @e_invitation.tour, notice: 'E invitation was successfully created.' }
        format.json { render :show, status: :created, location: @e_invitation }
      else
        format.html { render :new }
        format.json { render json: @e_invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /e_invitations/1
  # PATCH/PUT /e_invitations/1.json
  def update
    respond_to do |format|
      if @e_invitation.update(e_invitation_params)
        format.html { redirect_to @e_invitation, notice: 'E invitation was successfully updated.' }
        format.json { render :show, status: :ok, location: @e_invitation }
      else
        format.html { render :edit }
        format.json { render json: @e_invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /e_invitations/1
  # DELETE /e_invitations/1.json
  def destroy
    @e_invitation.destroy
    respond_to do |format|
      format.html { redirect_to e_invitations_url, notice: 'E invitation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_e_invitation
      @e_invitation = EInvitation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def e_invitation_params
      params.require(:e_invitation).permit(:recipient, :tour_id)
    end
end
