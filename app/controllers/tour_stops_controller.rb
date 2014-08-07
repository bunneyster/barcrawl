class TourStopsController < ApplicationController
  before_action :set_tour_stop, only: [:show, :edit, :update, :destroy]
  before_action :set_tour, only: [:create, :update]

  # GET /tour_stops
  # GET /tour_stops.json
  def index
    @tour_stops = TourStop.all
  end

  # GET /tour_stops/1
  # GET /tour_stops/1.json
  def show
  end

  # GET /tour_stops/new
  def new
    @tour_stop = TourStop.new(tour: Tour.find(params[:tour_id]))
  end

  # GET /tour_stops/1/edit
  def edit
  end

  # POST /tour_stops
  # POST /tour_stops.json
  def create
    @tour_stop = TourStop.new(tour_stop_params)

    respond_to do |format|
      if @tour_stop.save
        format.html { redirect_to @tour, notice: 'Tour stop was successfully created.' }
        format.json { render :show, status: :created, location: @tour_stop }
      else
        format.html { render :new }
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
        format.json { render :show, status: :ok, location: @tour_stop }
      else
        format.html { render :edit }
        format.json { render json: @tour_stop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tour_stops/1
  # DELETE /tour_stops/1.json
  def destroy
    @tour_stop.destroy
    respond_to do |format|
      format.html { redirect_to tour_stops_url, notice: 'Tour stop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour
      @tour = Tour.find(tour_stop_params[:tour_id])
    end
    
    def set_tour_stop
      @tour_stop = TourStop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tour_stop_params
      params.require(:tour_stop).permit(:tour_id, :venue_id, :status)
    end
end
