class VotesController < ApplicationController
  before_action :set_tour_stop, only: [:tally]
  before_action :set_tour, only: [:tally]
  before_action :set_vote, only: [:destroy]
  before_action :bounce_if_logged_out
  
  # POST /votes/dispatch
  def tally
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
      redirect_to @tour
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
        format.html { redirect_to @tour }
      else
        format.html { redirect_to @tour }
      end
    end
  end
  
  private
    
    def set_tour_stop
      @tour_stop = TourStop.find(params[:tour_stop_id])
    end    
  
    def set_tour
      @tour = Tour.find(@tour_stop.tour.to_param)
    end
    
    def set_vote
      @vote = Vote.find(params[:id])
    end
    
    def vote_params
      params.permit(:tour_stop_id, :score)
    end
end