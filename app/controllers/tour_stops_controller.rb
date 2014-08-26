class TourStopsController < ApplicationController
  before_action :set_tour_stop, only: [:show, :edit, :update, :destroy]
  before_action :set_tour, only: [:create, :update]
  before_action :bounce_if_logged_out

  # GET /tour_stops/new
  def new
    @venue_search = VenueSearch.new(tour: Tour.find(params[:tour_id]))
  end
  
  # POST /tours_stops/search
  def search
    @venue_search = VenueSearch.new(venue_search_params)
    @venue_search_results = VenueSearch.new(venue_search_params).results.page params[:page]
    @tour_stop = TourStop.new(tour: @venue_search.tour)
  end

  # POST /tour_stops
  # POST /tour_stops.json
  def create
    @tour_stop = TourStop.new(tour_stop_params)
    @vote = Vote.new(voter: @current_user,
                     tour_stop: @tour_stop,
                     score: 1)
    
    respond_to do |format|
      if @tour_stop.save and @vote.save
        format.html { redirect_to @tour, notice: 'Tour stop was successfully created.' }
        format.json { render :search, status: :created, location: @tour_stop }
      else
        format.html { redirect_to search_tour_stops_url, notice: 'Venue has already been proposed.' }
        format.json { render json: @tour_stop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tour_stops/1
  # PATCH/PUT /tour_stops/1.json
  def update
    respond_to do |format|
      if @tour_stop.update(tour_stop_params)
        format.html { redirect_to @tour, notice: 'Tour stop was successfully updated.' }
        format.json { render :search, status: :ok, location: @tour_stop }
      else
        format.html { render :search }
        format.json { render json: @tour_stop.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    def set_tour
      @tour = Tour.find(tour_stop_params[:tour_id])
    end
    
    def set_tour_stop
      @tour_stop = TourStop.find(params[:id])
    end
    
    def venue_search_params
      params.require(:venue_search).permit(:tour_id, :query)
    end

    def tour_stop_params
      params.require(:tour_stop).permit(:tour_id, :venue_id, :status)
    end
end
