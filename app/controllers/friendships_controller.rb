class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:destroy]
  before_action :bounce_if_logged_out

  # POST /friendships
  # POST /friendships.json
  def create
    @friendship = @current_user.friendships.build(friend_id: params[:friend_id])

    respond_to do |format|
      if @friendship.save
        format.html { redirect_to root_url, notice: 'Friendship was successfully created.' }
        format.json { render :show, status: :created, location: @friendship }
      else
        format.html { redirect_to root_url, notice: "Sorry you can't be their friend." }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Friendship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friendship_params
      params.require(:friendship).permit(:friend_id)
    end
end
