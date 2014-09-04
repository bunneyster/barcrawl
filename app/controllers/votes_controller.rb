class VotesController < ApplicationController
  before_action :set_tour_stop, only: [:tally]
  before_action :bounce_if_logged_out
  
  # POST /votes/dispatch
  def tally
    if vote_params[:score].to_i.abs != 1
      redirect_to @tour_stop.tour, notice: "Stop. You can't vote like that."
      return
    end 
    
    if !@current_user.invited_to?(@tour_stop.tour)
      redirect_to tour_path(@tour_stop.tour), notice: 'Join the tour to vote!'
      return
    end
    
    if @tour_stop.votes_from(@current_user).first
      previous = @tour_stop.votes_from(@current_user).first
      sum = previous.score + vote_params[:score].to_i
    else
      sum = vote_params[:score].to_i
    end
    
    case sum.abs
    # First click
    when 1
      create
    # Second click on same button
    when 2
      previous.destroy
      redirect_to @tour_stop.tour, notice: 'Vote undone.'
    # Second click on other button
    when 0
      previous.destroy
      create
    end
  end
  
  def create
    @vote = Vote.new(vote_params)
    @vote.voter = @current_user
    
    respond_to do |format|
      if @vote.save
        format.html { redirect_to @tour_stop.tour, notice: 'Successfully voted!' }
      else
        format.html { redirect_to @tour_stop.tour, notice: 'Could not vote.' }
      end
    end
  end
  
  private
    
    def set_tour_stop
      @tour_stop = TourStop.find(params[:tour_stop_id])
    end    
    
    def vote_params
      params.permit(:tour_stop_id, :score)
    end
end