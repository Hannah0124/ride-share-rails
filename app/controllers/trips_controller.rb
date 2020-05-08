class TripsController < ApplicationController

  def show 
    trip_id = params[:id] 
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil? 
      redirect_to root_path 
      return 
    end
  end 

  def new 
    @trip = Trip.new
  end


  def create 
    # raise
    @trip = Trip.new(trip_params)

    if @trip.save
      redirect_to trip_path(@trip.id)
      return 
    else 
      render :new, :bad_request 
      return 
    end 
  end


  def edit 
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)

    if @trip.nil?
      redirect_to root_path 
      return 
    end
  end 

  def update 
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id) 

    if @trip.nil? 
      redirect_to root_path 
      return 

    elsif @trip.update(trip_params) 
      redirect_to trip_path(@trip.id)
      return 

    else 
      render :edit, :bad_request
      return 
    end
  end

  def destroy 
    trip_id = params[:id] 
    @trip = Trip.find_by(id: trip_id) 

    if @trip.nil?
      redirect_to root_path 
      return 
    else 
      @trip.destroy 
      redirect_to trips_path 
      return 
    end
  end

  private 

  def trip_params 
    return params.require(:trip).permit(:driver_id, :passenger_id, :date, :rating, :cost)
  end
end

